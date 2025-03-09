<script setup>
import { ref } from "vue";
const active = ref(0);
</script>

<template>
  <div>
    <nav class="header">去中心化投票APP</nav>
    <main>
      <router-view />
    </main>
    <van-tabbar route v-model="active" active-color="#ee482f">
      <van-tabbar-item to="/" icon="cluster">分发票权</van-tabbar-item>
      <van-tabbar-item to="/account" icon="contact">账户信息</van-tabbar-item>
      <van-tabbar-item to="/board" icon="eye">投票看板</van-tabbar-item>
    </van-tabbar>
  </div>
</template>

<style lang="less" scoped>
// 中心居中
.header {
  height: 44px;
  color: #fff;
  background-color: #ee482f;
  text-align: center;
  line-height: 44px;
}
</style>

<style lang="less">
html,
body {
  margin: 0;
  padding: 0;
}
</style>