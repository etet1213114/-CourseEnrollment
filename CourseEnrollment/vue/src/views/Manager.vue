<template>
  <div>
    <div style="height: 60px; background-color: #afcaf5; display: flex; align-items: center; border-bottom: 1px solid #ddd">
      <div style="flex: 1">
        <div style="padding-left: 20px; display: flex; align-items: center">
          <img src="@/assets/imgs/logo.png" alt="" style="width: 40px">
          <div style="font-weight: bold; font-size: 24px; margin-left: 5px">學生選課管理系統</div>
        </div>
      </div>
      <div style="width: fit-content; padding-right: 10px; display: flex; align-items: center;">
        <img style="width: 40px; height: 40px; border-radius: 50%" :src="data.user.avatar || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'" alt="">
        <span style="margin-left: 5px">{{ data.user.name }}</span>
      </div>
    </div>

    <div style="display: flex">
      <div style="width: 200px; border-right: 1px solid #ddd; min-height: calc(100vh - 60px)">
        <el-menu
            router
            style="border: none"
            :default-active="router.currentRoute.value.path"
            :default-openeds="['/home', '2']"
        >
          <el-menu-item index="/home">
            <el-icon><HomeFilled /></el-icon>
            <span>系統首頁</span>
          </el-menu-item>
          <el-sub-menu index="2">
            <template #title>
              <el-icon><Promotion /></el-icon>
              <span>資訊管理</span>
            </template>
            <el-menu-item index="/notice" v-if="data.user.role === 'ADMIN'"><el-icon><Bell /></el-icon><span>公告資訊</span></el-menu-item>
            <el-menu-item index="/college"><el-icon><OfficeBuilding /></el-icon><span>學院資訊</span></el-menu-item>
            <el-menu-item index="/speciality"><el-icon><School /></el-icon><span>專業資訊</span></el-menu-item>
            <el-menu-item index="/course"><el-icon><Reading /></el-icon><span>課程資訊</span></el-menu-item>
            <el-menu-item index="/choice"><el-icon><Reading /></el-icon><span>選課資訊</span></el-menu-item>
          </el-sub-menu>
          <el-sub-menu index="3" v-if="data.user.role === 'ADMIN'">
            <template #title>
              <el-icon><Avatar /></el-icon>
              <span>用戶管理</span>
            </template>
            <el-menu-item index="/admin"><el-icon><User /></el-icon><span>管理員資訊</span></el-menu-item>
            <el-menu-item index="/teacher"><el-icon><User /></el-icon><span>教師資訊</span></el-menu-item>
            <el-menu-item index="/student"><el-icon><User /></el-icon><span>學生資訊</span></el-menu-item>
          </el-sub-menu>
          <el-menu-item v-if="data.user.role === 'ADMIN'" index="/person"><el-icon><User /></el-icon><span>個人資料</span></el-menu-item>
          <el-menu-item v-if="data.user.role === 'TEACHER'" index="/tPerson"><el-icon><User /></el-icon><span>個人資料</span></el-menu-item>
          <el-menu-item v-if="data.user.role === 'STUDENT'" index="/sPerson"><el-icon><User /></el-icon><span>個人資料</span></el-menu-item>
          <el-menu-item index="/password">
            <el-icon><Lock /></el-icon>
            <span>修改密碼</span>
          </el-menu-item>
          <el-menu-item index="login" @click="logout">
            <el-icon><SwitchButton /></el-icon>
            <span>退出系統</span>
          </el-menu-item>
        </el-menu>
      </div>

      <div style="flex: 1; width: 0; background-color: #f8f8ff; padding: 10px">
        <router-view @updateUser="updateUser" />
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from "vue";
import router from "@/router";
import {ElMessage} from "element-plus";

const data = reactive({
  user: JSON.parse(localStorage.getItem('system-user') || '{}')
})

if (!data.user?.id) {
  ElMessage.error('請登入！')
  router.push('/login')
}

const updateUser = () => {
  data.user = JSON.parse(localStorage.getItem('system-user') || '{}')
}

const logout = () => {
  ElMessage.success('退出成功')
  localStorage.removeItem('system-user')
  router.push('/login')
}
</script>

<style scoped>
.el-menu-item.is-active {
  background-color: #e0edfd !important;
}
.el-menu-item:hover {
  color: #1967e3;
}
:deep(th)  {
  color: #333;
}
</style>
