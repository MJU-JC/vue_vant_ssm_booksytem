<template>
    <div id="book">
        <nav-bar class="nav">
            <template v-slot:left> <div class="back" @click="back"></div></template>
            <template v-slot:center>编辑图书</template>
            <template v-slot:right></template>
        </nav-bar>


        <scroll class="content" top="1" bottom="50" ref="scroll" style="padding: 0px 5px">
            <van-form @submit="onSubmit">
                <van-field clearable name="book.barcode" v-model="barcode" label="图书条形码：" placeholder="请输入图书条形码" :rules="[{ required: true, message: '请填写图书条形码' }]" />
                <van-field autosize clearable name="book.bookName" v-model="bookName" label="图书名称：" placeholder="请输入图书名称" :rules="[{ required: true, message: '请填写图书名称' }]" />
                <van-field clearable name="book.price" v-model="price" type="number" label="图书价格：" placeholder="请输入图书条形码" :rules="[{ required: true, message: '请填写图书价格' }]" />
                <van-field clearable name="book.count" v-model="count" type="digit" label="图书库存：" placeholder="请输入图书库存" :rules="[{ required: true, message: '请填写图书库存' }]" />

                <van-field v-show="false" clearable name="book.bookTypeObj.bookTypeId" v-model="bookTypeObj_bookTypeId" label="图书分类：" />
                <van-field readonly clickable label="图书分类" :value="bookTypeObj_bookTypeName" right-icon="arrow-down" placeholder="选择图书分类" @click="showBookTypeObjPicker = true" />
                <van-picker v-show="showBookTypeObjPicker" show-toolbar :columns="bookTypeObjColumns" :default-index="1" @cancel="showBookTypeObjPicker = false" @confirm="onConfirmBookBypeObj" />


                <van-field readonly name="book.publishDate" label="出版日期" :value="publishDate"   placeholder="选择出版日期" @click="showPublishDatePicker = true" :rules="[{ required: true, message: '请选择出版日期' }]">
                    <template #button><van-button size="small" type="warning" @click.stop="clearPublishDate">清除</van-button></template>
                </van-field>
                <van-datetime-picker v-if="showPublishDatePicker" v-model="picker_publishDate" type="date" @cancel="showPublishDatePicker = false" title="选择出版日期" @confirm="onConfirmPublishDate"/>

                <van-field v-show="false" clearable name="book.bookPhoto" v-model="bookPhoto" label="图书图片："  :rules="[{ required: true, message: '图书图片地址不能为空' }]" />
                <div class="van-cell van-field" style="pointer-events: auto;">
                    <div class="van-cell__title van-field__label"><span>图书图片：</span></div>
                    <div class="van-cell__value van-field__value">
                        <div class="van-field__body">
                            <img class="avatar" :src="bookPhotoUrl"/>
                            <!-- 图片上传 -->
                            <img-upload name="bookPhoto" @uploadFinished="bookPhotoUpload"></img-upload>
                        </div>
                    </div>
                </div>

                <van-field clearable name="book.hitNum" v-model="hitNum" type="digit" label="图书浏览量：" placeholder="请输入图书浏览量" :rules="[{ required: true, message: '请填写图书浏览量' }]" />

                <div class="van-cell van-field" style="pointer-events: auto;">
                    <div class="van-cell__title van-field__label"><span>图书简介：</span></div>
                    <div class="van-cell__value van-field__value">
                        <div class="van-field__body">
                        </div>
                    </div>
                </div>
                <van-field v-show="false" name="book.bookDesc" v-model="bookDesc" rows="5" label="图书简介" type="textarea" maxlength="8000" placeholder="请输入图书简介" show-word-limit />
                <VueUeditorWrap  v-model="bookDesc" :config="editorConfig"/>

                <div class="van-cell van-field" style="pointer-events: auto;">
                    <div class="van-cell__title van-field__label"><span>图书文件：</span></div>
                    <div class="van-cell__value van-field__value">
                        <div class="van-field__body">
                             <a :href="bookFile==''?'#':'/' + bookFile" :style="bookFile==''?'':'text-decoration: underline'">{{bookFile==""?"暂无文件":bookFile}}</a>
                        </div>
                    </div>
                </div>

                <van-field v-show="false" readonly clearable name="book.bookFile" v-model="bookFile" label="图书文件：" />
                <div class="van-cell van-field" style="pointer-events: auto;">
                    <div class="van-cell__title van-field__label"><span>上传图书文件：</span></div>
                    <div class="van-cell__value van-field__value">
                        <div class="van-field__body">
                            <!-- 文件上传 -->
                            <file-upload name="bookFile" @uploadFinished="bookFileUpload"></file-upload>
                        </div>
                    </div>
                </div>


                <div style="margin: 16px;">
                    <van-button round block type="info" native-type="submit">更新</van-button>
                </div>
            </van-form>
        </scroll>
    </div>
</template>

<script>

    import NavBar from 'components/common/navbar/NavBar'
    import Scroll from '../../components/common/scroll/Scroll'

    import VueUeditorWrap from 'vue-ueditor-wrap'
    import ImgUpload from '../../components/content/ImgUpload'
    import FileUpload from '../../components/content/FileUpload'

    import { queryAllBookType } from 'network/BookType'
    import { updateBook} from "../../network/Book";
    import { getBook } from "../../network/Book";

    export default {
        name: "BookModify",
        components: {
            NavBar,
            Scroll,
            ImgUpload,
            FileUpload,
            VueUeditorWrap
        },
        data() {
            return {
                barcode: "",  //图书条形码
                bookName: "",  //图书名称
                bookTypeObjList: [], //图书分类列表
                bookTypeObj_bookTypeId: 0, //图书分类id
                bookTypeObj_bookTypeName: "", //图书分类名称
                showBookTypeObjPicker: false, //是否显示图书分类Picker
                bookTypeObjColumns: [], //图书分类Picker的选项
                price: "", //图书价格
                count: "", //图书库存
                bookPhoto: 'upload/NoImage.jpg', //图书图片路径
                bookPhotoUrl: '/upload/NoImage.jpg', //图书文件路径
                publishDate: '', //出版日期
                showPublishDatePicker:false, //是否显示图书出版日期Picker
                picker_publishDate: new Date(), //图书出版日期Picker的日期
                hitNum:"", //图书浏览量
                bookDesc: "", //图书描述
                bookFile: "", //图书文件路径

                // 简单配置
                editorConfig: {
                    // 编辑器不自动被内容撑高
                    autoHeightEnabled: false,
                    // 初始容器高度
                    initialFrameHeight: 280,
                    // 初始容器宽度
                    initialFrameWidth: '100%',
                    // 上传文件接口, 报错属于正常，若需要验证可使用(也是盗大神的)http://35.201.165.105:8000/controller.php
                    // 调试完毕打包上线则切换回/static/UEditor/php/controller.php即可，不用做其他处理
                    //serverUrl: 'http://localhost:8080/JavaWebProject/ueditor1_4_3/jsp/controller.jsp',
                }
            }
        },
        created() {
            /* 查询所有图书分类初始化下拉Picker */
            queryAllBookType().then(res => {
                this.bookTypeObjList = res.data;
                for(var i=0;i<this.bookTypeObjList.length;i++) {
                    this.bookTypeObjColumns.push(this.bookTypeObjList[i].bookTypeName)
                }
            });


            this.barcode = this.$route.params.barcode;  //接收图书条形码参数
            //向后端请求单条图书记录
            getBook(this.barcode).then(res => {
                var book = res.data;
                this.bookName = book.bookName;
                this.bookTypeObj_bookTypeId = book.bookTypeObj.bookTypeId;
                this.bookTypeObj_bookTypeName = book.bookTypeObj.bookTypeName;
                this.price = book.price;
                this.count = book.count;
                this.publishDate = book.publishDate;
                this.picker_publishDate = new Date(this.publishDate.replace(/-/g, '/'))
                this.bookPhoto = book.bookPhoto;
                this.bookPhotoUrl = "/" + book.bookPhoto;
                this.hitNum = book.hitNum;
                this.bookDesc = book.bookDesc;
                this.bookFile = book.bookFile;
            })

            document.getElementById("tabbar").style.display = "flex";
        },
        methods: {
            back() {
                this.$router.go(-1);
            },

            onConfirmBookBypeObj(value,index) {  //选中某个图书分类后响应
                this.bookTypeObj_bookTypeName = value;
                this.bookTypeObj_bookTypeId = this.bookTypeObjList[index].bookTypeId;
                this.showBookTypeObjPicker = false;
            },

            onSubmit(book) {  //向后台请求更新图书
                updateBook(book).then(res => {
                    console.log(res)
                    this.$notify.success('更新成功~')
                }).catch(error => { this.$notify.error(error)})
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
            bookPhotoUpload(name,data) {   //上传图书照片后的回调方法
                if(name == "bookPhoto") {
                    this.bookPhoto = data;
                }
            },
            bookFileUpload(name,data) {  //上传图书文件后的回调方法
                if(name == "bookFile") {
                    this.bookFile = data;
                }
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


    .van-dropdown-menu {  width: 100%; }


    .avatar {
        width: 100px;
        height: 100px;
        background-color: #f3f3f3;
        float: left;
        top: 5px;
        right: 5px;
        border-radius: 3px;
       margin-bottom: 26px;
    }



</style>