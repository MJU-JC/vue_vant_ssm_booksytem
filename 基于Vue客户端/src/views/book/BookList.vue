<template>

    <div id="book">
        <van-popup v-model="showQueryBookForm"  closeable position="top" :style="{ height: 'auto' }">
            <div class="bookQueryForm">
                <h3>图书查询</h3>
                <van-field clearable v-model="barcode" label="图书条形码：" placeholder="请输入图书条形码" />

                <van-field autosize clearable  v-model="bookName" label="图书名称：" placeholder="请输入图书名称" />

                <van-field readonly clickable label="图书分类" :value="bookTypeObj_bookTypeName" right-icon="arrow-down" placeholder="选择图书分类" @click="showBookTypeObjPicker = true" />
                <van-popup v-model="showBookTypeObjPicker" position="bottom">
                    <van-picker show-toolbar :columns="bookTypeObjColumns" @cancel="showBookTypeObjPicker = false" @confirm="onConfirmBookTypeObj" />
                </van-popup>

                <van-field readonly label="出版日期" :value="publishDate"   placeholder="选择出版日期" @click="showPublishDatePicker = true">
                    <template #button>
                        <van-button size="small" type="warning" @click.stop="clearPublishDate">清除</van-button>
                    </template>
                </van-field>
                <van-datetime-picker v-if="showPublishDatePicker" v-model="picker_publishDate" type="date" @cancel="showPublishDatePicker = false" title="选择出版日期" @confirm="onConfirmPublishDate" />

                <div class="queryBtn">
                    <van-button round  size= small type="primary" @click="queryBook">查询</van-button>
                </div>

            </div>
        </van-popup>


        <nav-bar class="nav" ref="nav" >
            <template v-slot:left><van-icon name="plus" size="25"  @click.stop="bookAdd" /></template>
            <template v-slot:center>图书列表</template>
            <template v-slot:right><van-icon name="search" size="25"  @click.stop="showQueryBookForm=true" /></template>
        </nav-bar>
        <scroll class="content" top="1" bottom="50" ref="scroll" :isPullDown="true" @pullingDown="pullingDown" :isPullUp="true" @pullingUp="pullingUp"  @iscroll="contentScroll">
            <div class="ignore-pull-down1" ref="pull" v-show="pullFlag">下拉更新</div>
            <div class="ignore-pull-down2" ref="pull" v-show="!pullFlag">
                <span class="ball1"></span><span class="ball2"></span><span class="ball3"></span>
            </div>

            <div class="bookList">
                <template @click="itemClick" v-for="book in bookList">
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
                        <div class="opt_view">
                            <van-button round  size= small type="primary"  @click.stop="bookEditClick(`${book.barcode}`)" >编辑</van-button>
                            <van-button round  size= small type="warning" @click.stop="bookDeleteClick(`${book.barcode}`)" style="margin-left:10px;">删除</van-button>
                        </div>
                    </div>
                </template>
            </div>

            <div class="block"></div>
        </scroll>
        <return-top @returnTop="returnTop" v-show="isReturnTop"></return-top>
    </div>

</template>

<script>
    import NavBar from '../../components/common/navbar/NavBar'
    import Scroll from '../../components/common/scroll/Scroll'
    import ReturnTop from '../../components/common/returntop/ReturnTop'

    import {queryBook,deleteBook} from '../../network/Book'
    import { queryAllBookType } from '../../network/BookType'


    export default {
        name: 'BookList',
        components: {
            NavBar,
            Scroll,
            ReturnTop
        },
        data() {
            return {
                bookList: [],  //界面需要展示的图书列表数据
                barcode: "", //图书条形码查询关键字
                bookName: "",  //图书名称查询关键字

                bookTypeObjList:[], //图书分类列表
                bookTypeObj_bookTypeId: 0,  //要查询的图书分类id
                bookTypeObj_bookTypeName: "不限制", //要查询的图书分类名称
                showBookTypeObjPicker: false, //是否显示图书分类Picker
                bookTypeObjColumns: ['不限制'], //图书分类Picker的选项初始化

                publishDate: "",  //出版日期
                showPublishDatePicker: false, //是否显示选择图书日期Picker
                picker_publishDate: new Date(), //图书日期Picker绑定的日期
                pullFlag: true,  //是否允许下拉刷新标志
                page: 1, //默认显示结果第1页
                showQueryBookForm: false, //是否显示查询图书表单

                isReturnTop: false,

            }
        },
        created() {
            //初始化图书类型下拉框数据
            queryAllBookType().then(res => {
                this.bookTypeObjList = res.data;
                for(var i=0;i<this.bookTypeObjList.length;i++) {
                    this.bookTypeObjColumns.push(this.bookTypeObjList[i].bookTypeName)
                }
            });
            //查询图书信息
            this.bookQuery("");
            document.getElementById("tabbar").style.display = "flex";
        },


        methods: {
            onConfirmBookTypeObj(value,index) {  //选中某个图书分类后响应
                this.bookTypeObj_bookTypeName = value;
                if(index == 0) this.bookTypeObj_bookTypeId = 0;
                else this.bookTypeObj_bookTypeId = this.bookTypeObjList[index-1].bookTypeId;
                this.showBookTypeObjPicker = false;
            },

            onConfirmPublishDate(value) {  //选中某个图书出版日期后的响应
                var year = value.getFullYear();
                var month = (value.getMonth()+1)<10?'0'+ (value.getMonth()+1): (value.getMonth()+1);
                var day = value.getDate()<10?'0'+value.getDate():value.getDate();
                this.publishDate = year + "-" +  month + "-" + day ;
                this.showPublishDatePicker = false;
            },
            clearPublishDate() {  //清空图书出版日期
               this.publishDate='';
               this.showPublishDatePicker=false;
            },

            bookAdd() {
                this.$router.push('/book/add');  //打开图片添加页面
            },

            queryBook() {
                this.page = 1;
                this.bookList = [];
                this.pullFlag = false;
                this.showQueryBookForm = false;
                this.bookQuery("QUERY");
            },

            bookQuery(action) {
                queryBook(this.barcode,this.bookName,this.bookTypeObj_bookTypeId,this.publishDate,this.page).then(res => {
                    //this.bookList.push(...res.data)
                    this.bookList = this.bookList.concat(res.data.list)
                    if(action == "QUERY") {
                        this.$notify.success('查询成功~');
                        this.$refs.scroll.refresh();
                    }
                    if(action == "UP") {  //上拉加载操作
                        if(res.data.list.length < 10){
                            this.$notify.error('没有更多数据了~')
                            return;
                        }
                        this.$refs.scroll.refresh();
                    }
                    if(action == "DOWN") {  //下拉刷新操作
                        this.$notify.success('刷新成功~');
                        this.$refs.scroll.finishPullDown();
                        this.$refs.scroll.refresh();
                        this.pullFlag = true
                    }
                })
            },
            bookDetailClick(barcode) {
                this.$router.push('/book/detail/' + barcode); //跳转到图书详情页
            },
            bookEditClick(barcode) {
                this.$router.push('/book/modify/' + barcode); //跳转到图书修改页
            },
            bookDeleteClick(barcode) {
                this.$dialog.confirm({
                    title: '删除图书:' + barcode,
                    message: '确定删除吗？'
                }).then(() => {
                    deleteBook(barcode).then(res => {
                        console.log(res)
                        this.bookList.forEach(function(book, index, arr) {
                            if(book.barcode == barcode) arr.splice(index, 1);
                        });
                    });
                });
            },
            pullingDown() {  //下拉刷新
                this.barcode = "";
                this.bookName = "";
                this.bookTypeObj_bookTypeId = 0;
                this.publishDate = "";
                this.page = 1;

                this.bookList = [];
                this.pullFlag = false;
                this.bookQuery("DOWN");


            },
            pullingUp() {  //上拉加载
                console.log("上拉加载")
                this.page = this.page + 1;
                this.$refs.scroll.finishPullUp();
                this.bookQuery("UP");
            },
            returnTop() {
                this.$refs.scroll.scrollTo(0, 0)
            },
            //滚动事件
            contentScroll(position) {
                this.isReturnTop = position.y < -800


            },
        }
    }
</script>

<style scoped>
    @import "../../assets/css/list_base.css";
    @import "BookList.css";
    #book {
        height: 100vh;
        width: 100vw;
        position: relative;
    }

</style>