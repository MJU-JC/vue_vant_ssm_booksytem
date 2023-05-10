<template>
  <tab-bar>
    <tab-bar-item v-for="(item,index) in tab" :key="index" :path="item.path" activeColor="#4fc08d" deActiveColor="#999">
      <template v-slot:icon>{{item.icon}}</template>
      <template v-slot:name>{{item.title}}</template>
    </tab-bar-item>
  </tab-bar>
</template>

<script>
import TabBar from '../../../components/common/tabbar/TabBar'
import TabBarItem from '../../../components/common/tabbar/TabBarItem'
export default {
  name: 'CustomerTabBar',
  components: {
    TabBar,
    TabBarItem
  },
  data() {
    return {
      tab: [{
        icon: '',
        title: '首页',
        path: '/home'
      },
      {
        icon: '',
        title: '图书列表',
        path: '/book/list'
      },
        {
          icon: '',
          title: '图书列表',
          path: '/book/list'
        },

      {
        icon: '',
        title: '个人中心',
        path: '/profile'
      }]
    }
  }
}
</script>

<style scoped>

</style>