// 图书信息业务处理
import request from './request'
import qs from 'qs'

/* 根据查询条件分页查询图书信息 */
export function queryBook(barcode, bookName, bookTypeObj_bookTypeId, publishDate, page) {
    return request({
        url: '/book/list',
        method: "POST",
        params: {
            "barcode": barcode,
            "bookName": bookName,
            "bookTypeObj.bookTypeId": bookTypeObj_bookTypeId,
            "publishDate": publishDate,
            "page": page,
            "rows": 10
        }
    })
}

/*查询最新上架图书*/
export function queryNewBook() {
    return request({
        url: '/book/new_list',
    })
}


/* 查询所有的图书信息*/
export function queryAllBook() {
    return request({
        url: '/book/listAll',
        method: "POST",
    })
}

/* 添加图书信息 */
export function addBook(book) {
    return request({
        url: '/book/add',
        method: "POST",
        data: qs.stringify(book),
        headers: { //添加请求头
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        }
    })
}

/* 更新图书信息 */
export function updateBook(book) {
    return request({
        url: '/book/update',
        method: "POST",
        data: qs.stringify(book),
        headers: { //添加请求头
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        }
    })
}

/* 根据主键图书条形码查询图书信息 */
export function getBook(barcode) {
    return request({
        url: '/book/get/' + barcode,
        method: "POST"
    })
}

/* 根据主键图书条形码删除图书 */
export function deleteBook(barcode) {
    return request({
        url: '/book/delete/' + barcode,
        method: "POST"
    })
}






