// 用户信息业务处理
import request from './request'
import qs from 'qs'



/* 更新用户信息 */
export function updateUserInfo(userInfo) {
    return request({
        url: '/userInfo/update',
        method: "POST",
        data: qs.stringify(userInfo),
        headers: { //添加请求头
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        }
    })
}

/* 根据主键用户名查询用户信息 */
export function getUserInfo() {
    return request({
        url: '/userInfo/self_get',
        method: "POST"
    })
}

