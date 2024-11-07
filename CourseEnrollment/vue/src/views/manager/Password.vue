<template>
  <div style="width: 50%">
    <div class="card" style="padding: 30px">
      <el-form :model="data.user" label-width="100px" style="padding-right: 50px">
        <el-form-item label="原密碼">
          <el-input v-model="data.user.password" show-password />
        </el-form-item>
        <el-form-item label="新密碼">
          <el-input v-model="data.user.newPassword" show-password />
        </el-form-item>
        <el-form-item label="確認新密碼">
          <el-input v-model="data.user.confirmPasword" show-password />
        </el-form-item>
        <div style="text-align: center">
          <el-button type="primary" @click="save">保存</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import {reactive} from "vue"
import request from "@/utils/request";
import {ElMessage} from "element-plus";
import router from "@/router";

const data = reactive({
  user: JSON.parse(localStorage.getItem('system-user') || '{}'),
})

// 把當前修改的使用者資訊儲存到後台資料庫
const save = () => {
  if (data.user.newPassword !== data.user.confirmPasword) {
    ElMessage.error('確認新密碼錯誤')
    return
  }
  request.put('/updatePassword', data.user).then(res => {
    if (res.code === '200') {
      ElMessage.success('修改密碼成功')
      // 清空快取
      localStorage.removeItem('system-user')
      router.push('/login')
    } else {
      ElMessage.error(res.msg)
    }
  })
}
</script>
