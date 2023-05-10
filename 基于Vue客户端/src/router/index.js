//前端路由代码
import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/**
 * 重写路由的push方法
 */
// const routerPush = Router.prototype.push
// Router.prototype.push = function push(location) {
//     return routerPush.call(this, location).catch(error => error)
// }  

const Home = () => import ('../views/home/Home') //引入首页组件页
const BookList = () => import('../views/book/BookList.vue') //引入图书列表组件页
const BookAdd = () => import('../views/book/BookAdd') //引入图书添加组件页
const BookModify = () => import('../views/book/BookModify') //引入图书修改组件页
const BookDetail = () => import('../views/book/BookDetail') //引入图书详情组件页
const UserInfoModify = () => import('../views/userInfo/UserInfoModify') //引入读者信息修改页
const Profile = () => import ('../views/profile/Profile') //引入个人中心组件页
const Login = () => import ('../views/login/Login') //引入登录组件页
const CreateAccount = () => import ('../views/login/CreateAccount') //引入创建账号组件页
const Coupon = () => import ('../views/profile/CouponExchange') //引入优惠卷组件页
const About = () => import ('../views/profile/About') //引入关于我们组件页

const routes = [{
    path: '',  // 根路径跳到登录页路由
    redirect: '/login'
  },
  {
    path: '/login', // 系统登录页路由
    component: Login
  },
  {
    path: '/register', // 创建新账号页路由
    component: CreateAccount
  },
  {
    path: '/home',   // 首页路由
    component: Home
  },

  {
    path: '/book/add', // 添加图书页路由
    component: BookAdd
  },
  {
    path: '/book/modify/:barcode', // 修改图书页路由
    component: BookModify
  },
  {
    path: '/book/list', // 图书查询页路由
    component: BookList
  },
  {
    path: '/book/detail/:barcode', // 图书详情页路由
    component: BookDetail
  },
  {
    path: '/userInfo/selfModify', //用户修改个人信息
    component: UserInfoModify
  },

  {
    path: '/Profile', // 个人中心页路由
    component: Profile,
  },
  {
    path: '/about', //关于我们页路由
    component: About
  },
  {
    path: '/coupon', // 优惠卷页路由
    component: Coupon
  }
]

const router = new Router({
  routes,
  mode: 'history'
})

export default router