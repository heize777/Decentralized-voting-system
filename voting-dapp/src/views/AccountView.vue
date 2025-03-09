<script setup>
import useWeb3 from "../hooks/useWeb3"
import { ref, onMounted } from "vue"

const web3Obj = ref(null)
const account = ref('')
const delegatorAddress = ref('')

const voteInfo = ref({})

const getVoteInfo = async () => {
  voteInfo.value = await web3Obj.value.voteContract.methods.voters(account.value).call()
}

const delegate = async () => {
  await web3Obj.value.voteContract.methods.delegate(delegatorAddress.value)
    .send({ from: account.value })
    .on('receipt', (receipt) => {
      console.log('委托成功', receipt)
    })
}

onMounted(async () => {
  web3Obj.value = await useWeb3()
  account.value = await web3Obj.value.getAccount()
  await getVoteInfo()
})

</script>

<template>
  <div class="box2">
    <van-divider>账户信息</van-divider>
    <van-space>
      <p class="label">当前账户</p>
      <p class="address">
        {{ account }}
      </p>
    </van-space>
    <br />
    <van-space>
      <p class="label">账户票数</p>
      <p class="address">
        {{ voteInfo.amount }}
      </p>
    </van-space>
    <br />
    <van-space>
      <p class="label">委托账户</p>
      <p class="address">
        {{ voteInfo.delegator }}
      </p>
    </van-space>
    <br />
    <van-space>
      <p class="label">是否已投票</p>
      <p class="address">
        {{ voteInfo.isVoded }}
      </p>
    </van-space>
    <br />
    <van-space>
      <p class="label">投票ID</p>
      <p class="address">
        {{ voteInfo.targetId }}
      </p>
    </van-space>
    <br />

    <div class="btn">
      <van-cell-group inset>
        <van-field v-model="delegatorAddress" label="受托人地址" placeholder="请输入受托人地址" />
      </van-cell-group>
      <van-button block @click="delegate">委托他人代投</van-button>
    </div>
  </div>
</template>