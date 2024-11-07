<template>
  <div class="login-container">
    <div class="login-box">
      <div style="font-weight: bold; font-size: 24px; text-align: center; margin-bottom: 30px; color: #1450aa">歡迎登入學生選課管理系統</div>
      <el-form :model="data.form" ref="formRef" :rules="data.rules">
        <el-form-item prop="username">
          <el-input :prefix-icon="User" size="large" v-model="data.form.username" placeholder="請輸入帳號" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input :prefix-icon="Lock" size="large" v-model="data.form.password" placeholder="請輸入密碼" show-password />
        </el-form-item>
        <el-form-item prop="role">
          <el-select size="large" style="width: 100%" v-model="data.form.role">
            <el-option value="ADMIN" label="管理員"></el-option>
            <el-option value="TEACHER" label="教師"></el-option>
            <el-option value="STUDENT" label="學生"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button size="large" type="primary" style="width: 100%" @click="login">登 入</el-button>
        </el-form-item>
      </el-form>
      <div style="text-align: right;">
        還沒有帳號？請 <a href="/register">註冊</a>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from "vue";
import { User, Lock } from "@element-plus/icons-vue";
import request from "@/utils/request";
import { ElMessage } from "element-plus";
import router from "@/router";

const data = reactive({
  form: {},
  rules: {
    username: [
      { required: true, message: '請輸入帳號', trigger: 'blur' },
    ],
    password: [
      { required: true, message: '請輸入密碼', trigger: 'blur' },
    ],
  }
})

const formRef = ref()

// 點擊登入按鈕的時候會觸發這個方法
const login = () => {
  formRef.value.validate((valid => {
    if (valid) {
      // 調用後台的接口
      request.post('/login', data.form).then(res => {
        if (res.code === '200') {
          ElMessage.success("登入成功")
          router.push('/')
          localStorage.setItem('system-user', JSON.stringify(res.data))
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
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
  //background: linear-gradient(to top, #7f7fd5, #86a8e7, #91eae4);
  background-image: url("@/assets/imgs/bg.jpg");
  background-size: cover;
}
.login-box {
  width: 400px;
  padding: 50px 30px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0,.1);
  background-color: rgba(255, 255, 255, .5);
}
</style>
