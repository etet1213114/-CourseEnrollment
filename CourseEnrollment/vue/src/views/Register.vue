<template>
  <div class="login-container">
    <div class="login-box">
      <div style="font-weight: bold; font-size: 24px; text-align: center; margin-bottom: 30px; color: #1450aa">歡 迎 註 冊</div>
      <el-form :model="data.form"  ref="formRef" :rules="data.rules">
        <el-form-item prop="username">
          <el-input :prefix-icon="User" size="large" v-model="data.form.username" placeholder="請輸入帳號" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input :prefix-icon="Lock" size="large" v-model="data.form.password" placeholder="請輸入密碼" show-password />
        </el-form-item>
        <el-form-item prop="confirmPassword">
          <el-input :prefix-icon="Lock" size="large" v-model="data.form.confirmPassword" placeholder="請確認密碼" show-password />
        </el-form-item>
        <el-form-item>
          <el-button size="large" type="primary" style="width: 100%" @click="register">註 冊</el-button>
        </el-form-item>
      </el-form>
      <div style="text-align: right;">
        還沒有帳號？請 <a href="/login">登入</a>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import { User, Lock } from "@element-plus/icons-vue";
import request from "@/utils/request";
import {ElMessage} from "element-plus";
import router from "@/router";

const validatePass = (rule, value, callback) => {
  if (!value) {
    callback(new Error('請確認密碼'))
  } else if (value !== data.form.password) {
    callback(new Error('兩次輸入的密碼不一致'))
  } else {
    callback()
  }
}

const data = reactive({
  form: { role: 'USER' },
  rules: {
    username: [
      { required: true, message: '請輸入帳號', trigger: 'blur' },
    ],
    password: [
      { required: true, message: '請輸入密碼', trigger: 'blur' },
    ],
    confirmPassword: [
      { validator: validatePass, trigger: 'blur' },
    ],
  }
})

const formRef = ref()

// 點擊註冊按鈕時會觸發這個方法
const register = () => {
  formRef.value.validate((valid => {
    if (valid) {
      // 呼叫後端的接口
      request.post('/register', data.form).then(res => {
        if (res.code === '200') {
          ElMessage.success("註冊成功")
          router.push('/login')
        } else {
          ElMessage.error(res.msg)
        }
      })
    }
  })).catch(error => {
    console.error(error)
  })
}
</script>

<style scoped>
.login-container {
  height: 100vh;
  overflow:hidden;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(to bottom, #a8c0ff, #3f2b96);
  background-size: cover;
}
.login-box {
  width: 350px;
  padding: 50px 30px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0,.1);
  background-color: rgba(255, 255, 255, .5);
}
</style>
