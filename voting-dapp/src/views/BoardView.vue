<script setup>
import { ref, onMounted } from 'vue'
import useWeb3 from '../hooks/useWeb3'

const webObj = ref(null)
const boardInfo = ref([])

const getBoardInfo = async () => {
  boardInfo.value = await webObj.value.voteContract.methods.getBoardInfo().call()
}

const vote = async (index) => {
  const account = await webObj.value.getAccount()
  await webObj.value.voteContract.methods.vote(index).send({ from: account })
}

onMounted(async () => {
  webObj.value = await useWeb3()
  getBoardInfo()
})
</script>

<template>
  <div class="box3">
    <van-divider>投票看板</van-divider>
    <van-cell :title="item.name" icon="shop-o" v-for="(item, index) in boardInfo" :key="index">
      <template #right-icon>
        <van-button @click="vote(index)">{{ item.totalAmount }}</van-button>
      </template>
    </van-cell>
  </div>
</template>