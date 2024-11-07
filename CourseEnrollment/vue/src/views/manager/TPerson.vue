<template>
  <div style="width: 50%">
    <div class="card" style="padding: 30px">
      <el-form :model="data.user" label-width="100px" style="padding-right: 50px">
        <div style="margin: 20px 0; text-align: center">
          <el-upload :show-file-list="false" class="avatar-uploader" :action="uploadUrl" :on-success="handleFileUpload">
            <img v-if="data.user.avatar" :src="data.user.avatar" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
        </div>
        <el-form-item label="賬號">
          <el-input disabled v-model="data.user.username" autocomplete="off" />
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="data.user.name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="性別" prop="sex">
          <el-select v-model="data.user.sex" placeholder="請選擇性別" style="width: 100%">
            <el-option label="男" value="男"></el-option>
            <el-option label="女" value="女"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="職稱" prop="title">
          <el-select v-model="data.user.title" placeholder="請選擇職稱" style="width: 100%">
            <el-option label="講師" value="講師"></el-option>
            <el-option label="副教授" value="副教授"></el-option>
            <el-option label="教授" value="教授"></el-option>
          </el-select>
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

// 文件上傳的接口地址
const uploadUrl = import.meta.env.VITE_BASE_URL + '/files/upload'

const data = reactive({
  user: JSON.parse(localStorage.getItem('system-user') || '{}'),
})

const handleFileUpload = (file) => {
  data.user.avatar = file.data
}

const emit = defineEmits(["updateUser"])
// 把當前修改的用戶信息存儲到後台數據庫
const save = () => {
  request.put('/teacher/update', data.user).then(res => {
    if (res.code === '200') {
      ElMessage.success('更新成功')
      //把更新後的用戶信息存儲到快取
      localStorage.setItem('system-user', JSON.stringify(data.user))
      emit('updateUser')
    } else {
      ElMessage.error(res.msg)
    }
  })
}
</script>

<style scoped>
.avatar-uploader .avatar {
  width: 120px;
  height: 120px;
  display: block;
}
</style>

<style>
.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 120px;
  height: 120px;
  text-align: center;
}
</style>
