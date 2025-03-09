import Web3 from 'web3'
import VoteJSON from "../contract/Vote.json"

const useWeb3 = async () => {
  // const web3 = new Web3(Web3.givenProvider || "wss://eth-sepolia.g.alchemy.com/v2/BdVBuYPZGER87RysWqWzPLUk9nMKIUED")
  const web3 = new Web3(window.ethereum)

  const contractAddress = "0xc632192ba2D8Ca68ae9c4BF11dc637DD0bE1305a"
  
  const voteContract = new web3.eth.Contract(VoteJSON.abi, contractAddress)
  const getAccount = async () => {
    // const accounts = await window.ethereum.request({ method: "eth_requestAccounts" })
    const accounts = await web3.eth.requestAccounts()
    return accounts[0]
  }

  return {
    web3,
    contractAddress,
    voteContract,
    getAccount
  }
}

export default useWeb3