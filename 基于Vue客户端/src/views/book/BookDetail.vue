<template>
    <div id="book">
        <nav-bar class="nav">
            <template v-slot:left><div class="back" @click="back"></div></template>
            <template v-slot:center>图书详情</template>
            <template v-slot:right></template>
        </nav-bar>


        <scroll class="content" top="1" bottom="50" ref="scroll" style="padding: 0px 5px">
            <div class="main-box">
                <div class="info-bar">
                    <span class="title2">&nbsp;图书条形码：</span>
                    <span class="title3">{{barcode}}</span>
                </div>

                <div class="info-bar">
                    <span class="title2">&nbsp;图书名称：</span>
                    <span class="title3">{{bookName}}</span>
                </div>

                <div class="info-bar">
                    <span class="title2">&nbsp;图书价格：</span>
                    <span class="title3">{{price}}</span>
                </div>

                <div class="info-bar">
                    <span class="title2">&nbsp;图书库存：</span>
                    <span class="title3">{{count}}</span>
                </div>

                <div class="info-bar">
                    <span class="title2">&nbsp;图书分类：</span>
                    <span class="title3">{{bookTypeObj_bookTypeName}}</span>
                </div>

                <div class="info-bar">
                    <span class="title2">&nbsp;出版日期：</span>
                    <span class="title3">{{publishDate}}</span>
                </div>


                <div class="info-bar" style="height:140px;">
                    <span class="title2">&nbsp;图书图片：</span>
                    <span class="title3"> <img class="avatar" :src="bookPhotoUrl"/></span>
                </div>


                <div class="info-bar">
                    <span class="title2">&nbsp;浏览量：</span>
                    <span class="title3">{{hitNum}}</span>
                </div>


                <div class="info-bar">
                    <span class="title2">&nbsp;图书文件：</span>
                    <span class="title3">
                        <a :href="bookFile==''?'#':'/' + bookFile" :style="bookFile==''?'':'text-decoration: underline'">{{bookFile==""?"暂无文件":"点击查看"}}</a>
                    </span>
                </div>


                <div class="info-bar">
                    <span class="title2">&nbsp;图书简介:</span>
                    <span class="desc" v-html="bookDesc"> </span>
                </div>

                <div class="info-bar">
                    <span class="title2">&nbsp;浏览量：</span>
                    <span class="title3">{{hitNum}}</span>
                </div>

            </div>
            <div style="margin: 16px;">
                <van-button round block type="info" native-type="submit" @click.stop="back">返回</van-button>
            </div>

        </scroll>
    </div>
</template>

<script>
    import NavBar from 'components/common/navbar/NavBar'
    import Scroll from 'components/common/scroll/Scroll'
    import { queryAllBookType } from 'network/BookType'
    import { getBook } from "../../network/Book";

    export default {
        name: "BookDetail",
        components: {
            NavBar,
            Scroll,
        },
        data() {
            return {
                barcode: "", //图书条形码
                bookName: "", //图书名称
                bookTypeObj_bookTypeName: "", //图书分类
                price: "", //图书价格
                count: "", //图书库存
                publishDate: '', //出版日期
                bookPhotoUrl: '/upload/NoImage.jpg', //图书图片路径
                hitNum:"", //图书浏览量
                bookDesc: "", //图书描述
                bookFile: "", //图书文件路径
            }
        },
        created() {

            this.barcode = this.$route.params.barcode; //接收到的图书条形码
            //向后端请求单条图书记录
            getBook(this.barcode).then(res => {
                var book = res.data;
                this.bookName = book.bookName;
                this.bookTypeObj_bookTypeName = book.bookTypeObj.bookTypeName;
                this.price = book.price;
                this.count = book.count;
                this.publishDate = book.publishDate;
                //this.picker_publishDate = new Date(this.publishDate.replace(/-/g, '/'))
                this.bookPhotoUrl = "/" + book.bookPhoto;
                this.hitNum = book.hitNum;
                this.bookDesc = book.bookDesc;
                this.bookFile = book.bookFile;
            })


            document.getElementById("tabbar").style.display = "flex";
        },
        methods: {
            back() {
                this.$router.replace('/book/list')
            },
        },

    }
</script>

<style scoped>

    .nav {
        background-color: #54bf8e;
        color: #fff;
    }

    .back {
        font-family: 'icomoon';
        font-size: 30px;
    }

    #book {
        height: 100vh;
        width: 100vw;
        position: relative;
    }

    .content {
        position: fixed;
        top: 50px;
        left: 0;
        right: 0px;
        bottom: 49px;
    }

    .header {
        background-color: #fff;
        position: relative;
        padding: 0 15px;
        padding-bottom: 10px;
        overflow-x: scroll;
        box-shadow: 0 1px 6px rgba(0, 0, 0, .08);
    }

    .header p{
        margin-top: 40px;
        color: #3c3c3c;
        line-height: 25px;
        text-indent: 25px;
    }

    .main-box {
        background-color: #fff;
        margin: 10px 0;
        box-shadow: 0 1px 6px rgba(0, 0, 0, .08);
    }

    .info-bar {
        height: auto;
        border-bottom: 1px solid #f3f3f3;
        padding: 0 15px;
        display: block;
        clear:both;
    }

    .title2 {
        width:35%;
        line-height: 46px;
        font-weight: 600;
        font-family: 'icomoon';
    }

    .title3 {
        width: auto;
        height: 100%;
        text-align: right;
        line-height: 46px;
        color: #3c3c3c;
        float: right;
    }

    .desc {
        width: 100%;
        line-height: 25px;
        color: #3c3c3c;
        clear:both;
    }

    .avatar {
        width: 100px;
        height: 100px;
        background-color: #f3f3f3;
        border-radius: 3px;
    }


</style>