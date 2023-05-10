<template>
  <div class="home">
    <div class="bgc"></div>
    <location :locationInfo="locationInfo"></location>
    <scroll  class="content" ref="scroll" top="66" >
      <home-swiper></home-swiper>

      <div class="bookList">
        <template v-for="book in bookList">
          <div class="bookItem" :key="book.barcode" @click.stop="bookDetailClick(`${book.barcode}`)">
            <div class="content_view">
              <div class="bookImg">
                <img v-lazy="'/' + book.bookPhoto">
              </div>
              <div class="bookText">
                <div>图书条形码：{{book.barcode}}</div>
                <div>图书名称：{{book.bookName}}</div>
                <div>图书所在类别：{{book.bookTypeObj.bookTypeName}}</div>
                <div>图书价格：{{book.price}}</div>
                <div>库存：{{book.count}}</div>
                <div>出版日期：{{book.publishDate}}</div>
              </div>
            </div>

          </div>
        </template>
      </div>



    </scroll>
  </div>
</template>

<script>
import NavBar from '../../components/common/navbar/NavBar'
import Scroll from '../../components/common/scroll/Scroll'

import Location from './childComps/Location'
import HomeSwiper from './childComps/HomeSwiper'

import { getShop } from '../../network/home'
import {getLocation, getDistance} from '../../common/utils'

import {queryNewBook} from '../../network/Book'



export default {
  name: 'Home',
  components: {
    NavBar,
    Scroll,
    Location,
    HomeSwiper
  },
  data() {
    return {
      bookList: [],
      storeList: [],
      locationInfo: "定位中...",
      sticky: false,
      position: {lng: 0, lat: 0}
    }
  },
  created() {
    this.$toast.loading()
    this.getLocation()

    queryNewBook().then(res => {
      this.bookList = this.bookList.concat(res.data.list)
    })

  },
  methods: {
    bookDetailClick(barcode) {
      this.$router.push('/book/detail/' + barcode); //跳转到图书详情页
    },
    getShop() {
      getShop().then(ret => {
        let data = ret.data
        for(let i in data) {
          data[i].distance = getDistance(data[i].lng, data[i].lat, this.position.lng, this.position.lat)
        }
        function compare(property){
          return function(a,b){
            var value1 = a[property];
            var value2 = b[property];
            return value1 - value2;
          }
        }
        data.sort(compare('distance'))
        this.storeList = data
      })
    },
    getLocation() {
      //等待 1000ms 
      new Promise((resolve, reject) => {
        let timer = setTimeout(() => {
          reject()
        },3000)
        getLocation(ret => {
          console.log('定位信息', ret)
          if(ret) {
            let address = ret.formattedAddress
            address = address.replace(ret.addressComponent.province,"")
            address = address.replace(ret.addressComponent.city,"")
            address = address.replace(ret.addressComponent.district,"")
            address = address.replace(ret.addressComponent.township,"")
            address = address.replace(ret.addressComponent.streetNumber,"")
            this.locationInfo = address
            this.position.lng = ret.position.lng
            this.position.lat = ret.position.lat
          }
          this.$toast.hide()
          clearTimeout(timer)
          resolve()
          // this.$bus.$emit('aflocation')
        })
      }).then(() => {
        this.$toast.hide()
      }).catch(() => {
        this.locationInfo = "设备不支持定位"
        this.$toast.hide()
        // this.$bus.$emit('aflocation')
      })
    }
  },
  activated() {
    this.$refs.scroll.refresh()
  }

}
</script>

<style scoped>
  @import  '../book/BookList.css';
.home {
  width: 100vw;
  height: 100vh;
  position: relative;
  background-color: #54bf8e;
  background-size: 100%;
}
.content {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 49px;
}
.bgc {
  width: 375px;
  height: 170px;
  /*background: url(~assets/images/homebg.png) no-repeat;*/
  background-size: 100%;
  position: fixed;
  top: 0;
}

</style>