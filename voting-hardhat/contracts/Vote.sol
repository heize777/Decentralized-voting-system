// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.24;

contract Vote {

  // 投票人结构体
  struct Voter {
    uint256 amount; // 投票数量
    bool isVoded;  // 是否投票
    address delegator;  // 代理人地址
    uint256 targetId;  // 主题id
  }

  mapping (address => Voter) voters;

  // 主题结构体
  struct Board {
    string name; // 主题名称
    uint256 totalAmount; // 投票总数
  }

  Board[] boards; // 主题列表

  constructor() {
    
  }
}