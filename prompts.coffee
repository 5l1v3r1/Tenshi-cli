colors            = require 'colors/safe'


module.exports = properties:
  username:
    message: colors.green('Vui lòng nhập email hoặc tên tài khoản facebook')
    required: true
    warning: 'EMAIL hoặc TÀI KHOẢN FACEBOOK'
  password:
    message: colors.green('Vui lòng nhập password facebook')
    required: true
    warning: '100% AN TOÀN TUYỆT ĐỐI BẠN HÃY YÊN TÂM'
  prefix:
    message: colors.green('Bạn muốn ký tự đặc biệt để gọi tenshi là gì ?')
    required: true
    default: '!'
    warning: 'không được để trống!!'
  type:
    message: colors.green('Bạn muốn sử dụng bot cá nhân, hay cho cả group (self or group)')
    required: true
    default: 'self'
  confirm:
    message: colors.green('Lưu lại vào file config?')
    required: true
    validator: /y[es]*|n[o]?/
    warning: 'Bạn phải trả lời yes hoặc no'
    default: 'y'
