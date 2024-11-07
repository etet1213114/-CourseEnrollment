<template>
  <div>

    <div class="card" style="margin-bottom: 5px;">
      <el-input v-model="data.name" style="width: 300px; margin-right: 10px" placeholder="請輸入課程名稱查詢"></el-input>
      <el-button type="primary" @click="load">查詢</el-button>
      <el-button type="info" style="margin: 0 10px" @click="reset">重置</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table :data="data.tableData" stripe>
        <el-table-column label="課程名稱" prop="name"></el-table-column>
        <el-table-column label="授課教師" prop="teacherName"></el-table-column>
        <el-table-column label="選課學生" prop="studentName"></el-table-column>
        <el-table-column label="操作" align="center" width="160" v-if="data.user.role === 'STUDENT'">
          <template #default="scope">
            <el-button type="danger" @click="handleDelete(scope.row.id)">取消選課</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div class="card">
      <el-pagination background layout="prev, pager, next" v-model:page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total"/>
    </div>

  </div>
</template>

<script setup>
import request from "@/utils/request";
import {reactive} from "vue";
import {ElMessageBox, ElMessage} from "element-plus";

const data = reactive({
  user: JSON.parse(localStorage.getItem('system-user') || '{}'),
  pageNum: 1,
  pageSize: 10,
  total: 0,
  form: {},
  tableData: [],
  name: null
})

// 分頁查詢
const load = () => {
  let teacherId = null
  let studentId = null
  if (data.user.role === 'TEACHER') {
    teacherId = data.user.id
  }
  if (data.user.role === 'STUDENT') {
    studentId = data.user.id
  }
  request.get('/choice/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name,
      teacherId: teacherId,
      studentId: studentId
    }
  }).then(res => {
    data.tableData = res.data?.list
    data.total = res.data?.total
  })
}

// 刪除
const handleDelete = (id) => {
  ElMessageBox.confirm('取消後可能再也選不到這門課了哦?', '取消選課', { type: 'warning' }).then(res => {
    request.delete('/choice/deleteById/' + id).then(res => {
      if (res.code === '200') {
        load()
        ElMessage.success('操作成功')
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(err => {})
}

// 重置
const reset = () => {
  data.name = null
  load()
}

load()
</script>
