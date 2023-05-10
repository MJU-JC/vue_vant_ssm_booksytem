import request from './request'

/* 查询所有的图书分类信息 */
export function queryAllBookType() {
    return request({
        url: '/bookType/listAll',
        method: "POST",
    })
}