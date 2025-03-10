<script setup>
import useWeb3 from "../hooks/useWeb3"
import { ref, onMounted } from "vue"

const web3Obj = ref(null)

const host = ref("0x0000000000000000000000000000000000000000")

const voterAddress = ref("")
const getHost = async () => {
  host.value = await web3Obj.value.voteContract.methods.host().call()
}

const mandate = async () => {
  const voterArr = eval(voterAddress.value)
  const account = await web3Obj.value.getAccount()
  await web3Obj.value.voteContract.methods
    .mandate(voterArr)
    .send({ from: account })
    .on('receipt', (receipt) => {
      console.log('选票分发成功', receipt)
    })
}

const initEventListen = async () => {
  web3Obj.value.voteContract.events.voteSuccess({ fromBlock: 0 }, (error, event) => {
    console.log('事件监听成功', event)
  }).on('data', (event) => {
    console.log('智能合约监听事件', event.events.voteSuccess.returnValues)
  })
}

onMounted(async () => {
  web3Obj.value = await useWeb3()
  initEventListen()
  getHost()
})

</script>

<template>
  <div class="box1">
    <van-divider>分发票权</van-divider>
    <div class="host">
      <van-space>
        <p class="label"><van-icon name="manager" />主持人地址:</p>
        <p class="address">{{ host }}</p>
      </van-space>
    </div>
    <div>
      <van-space>
        <p class="label"><van-icon name="friends-o" />投票人地址:</p>
        <textarea class="votors" v-model="voterAddress"></textarea>
      </van-space>
    </div>
    <div class="btn">
      <van-button block @click="mandate">开始分发选票</van-button>
    </div>
  </div>
</template>
