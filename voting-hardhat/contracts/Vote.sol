// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract Vote {

  // 投票人结构体
  struct Voter {
    uint256 amount; // 投票数量
    bool isVoded;  // 是否投票
    address delegator;  // 代理人地址
    uint256 targetId;  // 主题id
  }

  mapping (address => Voter) public voters;

  // 主题结构体
  struct Board {
    string name; // 主题名称
    uint256 totalAmount; // 投票总数
  }

  // 主题列表
  Board[] boards; 

  // 主持人
  address public host;

  event voteSuccess(string);

  constructor(string[] memory nameList) {
    // 主持人是部署合约的人
    host = msg.sender;

    // 主持人初始化票数
    voters[host].amount = 1;

    // 主持人初始化投票状态
    voters[host].isVoded = false;

    // 初始化主题
    for (uint i = 0; i < nameList.length; i++){
      Board memory boardItem = Board(nameList[i], 0);
      boards.push(boardItem);
    }
  }

  // 返回看板集合
  function getBoardInfo() public view returns (Board[] memory) {
    return boards;
  }

  // 给某一些地址赋予投票权
  function mandate(address[] calldata addressList) public onlyOwner {
    for (uint256 i = 0; i < addressList.length; i++) {
        // 给没有投过票的的地址增加票数
        if(!voters[addressList[i]].isVoded) {
            voters[addressList[i]].amount = 1;
        }
    }
  }

  // 投票
  function vote(uint256 _targetId) public {
    Voter storage sender = voters[msg.sender];
    // 投过票的人不能投了
    require(sender.isVoded==false, "You already voted. You can't vote again");
    // 没有票的也不能投
    require(sender.amount != 0,"You can not vote");
    sender.isVoded = true;
    sender.targetId = _targetId;
    boards[_targetId].totalAmount += sender.amount;

    emit voteSuccess("Vote successfully");
  }

  // 把票委托给别人
  function delegate(address to) public {
    Voter storage sender = voters[msg.sender];
    // 如果自己已经投过票了，就不能委托给别人了
    require(!sender.isVoded, "You already voted");
    // 不能委托给自己
    require(msg.sender != to, "Can't delegate to yourself");
    // 不能循环委托
    while (voters[to].delegator != address(0))  {
        to = voters[to].delegator;
        require(to != msg.sender, "Non-cyclic authorization");
    }

    // 开始委托
    sender.delegator = to;
    sender.isVoded = true;

    // 代理人数据修改
    Voter storage proxy = voters[to];

    // 投了票就追票
    if(proxy.isVoded) {
        boards[proxy.targetId].totalAmount += proxy.amount;
    } else {
        // 没有就给他加票
        proxy.amount += sender.amount;
    }
  }

  modifier onlyOwner() {
    require(msg.sender == host, "You don't have permission.");
    _;
  }
}
