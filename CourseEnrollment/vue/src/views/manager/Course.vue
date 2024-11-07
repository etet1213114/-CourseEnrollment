<template>
  <div>

    <div class="card" style="margin-bottom: 5px;">
      <el-input v-model="data.name" style="width: 300px; margin-right: 10px" placeholder="請輸入課程名稱查詢"></el-input>
      <el-button type="primary" @click="load">查詢</el-button>
      <el-button type="info" style="margin: 0 10px" @click="reset">重置</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <div style="margin-bottom: 10px" v-if="data.user.role === 'ADMIN'">
        <el-button type="primary" @click="handleAdd">新增</el-button>
      </div>
      <el-table :data="data.tableData" stripe>
        <el-table-column label="課程名稱" prop="name"></el-table-column>
        <el-table-column label="課程介紹" prop="content" show-overflow-tooltip></el-table-column>
        <el-table-column label="課程學分" prop="score"></el-table-column>
        <el-table-column label="授課教師" prop="teacherName"></el-table-column>
        <el-table-column label="開班人數" prop="num"></el-table-column>
        <el-table-column label="上課時間" prop="time"></el-table-column>
        <el-table-column label="上課地點" prop="location"></el-table-column>
        <el-table-column label="所屬學院" prop="collegeName"></el-table-column>
        <el-table-column label="已選人數" prop="alreadyNum"></el-table-column>
        <el-table-column label="操作" align="center" width="160" v-if="data.user.role !== 'TEACHER'">
          <template #default="scope" v-if="data.user.role === 'ADMIN'">
            <el-button type="primary" @click="handleEdit(scope.row)">編輯</el-button>
            <el-button type="danger" @click="handleDelete(scope.row.id)">刪除</el-button>
          </template>
          <template #default="scope" v-else>
            <el-button type="primary" @click="choiceCourse(scope.row)" :disabled="scope.row.num === scope.row.alreadyNum">選課</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div class="card">
      <el-pagination background layout="prev, pager, next" v-model:page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total"/>
    </div>

    <el-dialog title="課程資訊" width="40%" v-model="data.formVisible" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="data.form" label-width="100px" style="padding-right: 50px">
        <el-form-item label="課程名稱" prop="name">
          <el-input v-model="data.form.name" autocomplete="off" />
        </el-form-item>
        <el-form-item label="課程介紹" prop="content">
          <el-input type="textarea" :rows="4" v-model="data.form.content" autocomplete="off" />
        </el-form-item>
        <el-form-item label="課程學分" prop="score">
          <el-input v-model="data.form.score" autocomplete="off" />
        </el-form-item>
        <el-form-item label="授課教師" prop="teacherId">
          <el-select v-model="data.form.teacherId" placeholder="請選擇教師">
            <el-option
                v-for="item in data.teacherData"
                :key="item.id"
                :label="item.name"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="開班人數" prop="num">
          <el-input v-model="data.form.num" autocomplete="off" />
        </el-form-item>
        <el-form-item label="上課時間" prop="time">
          <el-input v-model="data.form.time" autocomplete="off" />
        </el-form-item>
        <el-form-item label="上課地點" prop="location">
          <el-input v-model="data.form.location" autocomplete="off" />
        </el-form-item>
        <el-form-item label="所屬學院" prop="content">
          <el-select v-model="data.form.collegeId" placeholder="請選擇學院">
            <el-option
                v-for="item in data.collegeData"
                :key="item.id"
                :label="item.name"
                :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
      <span class="dialog-footer">
        <el-button @click="data.formVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">保 存</el-button>
      </span>
      </template>
    </el-dialog>

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
  formVisible: false,
  form: {},
  tableData: [],
  name: null,
  collegeData: [],
  teacherData: []
})

// 分頁查詢
const load = () => {
  let teacherId = null
  if (data.user.role === 'TEACHER') {
    teacherId = data.user.id
  }
  request.get('/course/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name,
      teacherId: teacherId,
    }
  }).then(res => {
    data.tableData = res.data?.list
    data.total = res.data?.total
  })
}

// 新增
const handleAdd = () => {
  data.form = {}
  data.formVisible = true
}

// 編輯
const handleEdit = (row) => {
  data.form = JSON.parse(JSON.stringify(row))
  data.formVisible = true
}

// 新增保存
const add = () => {
  request.post('/course/add', data.form).then(res => {
    if (res.code === '200') {
      load()
      ElMessage.success('操作成功')
      data.formVisible = false
    } else {
      ElMessage.error(res.msg)
    }
  })
}

// 編輯保存
const update = () => {
  request.put('/course/update', data.form).then(res => {
    if (res.code === '200') {
      load()
      ElMessage.success('操作成功')
      data.formVisible = false
    } else {
      ElMessage.error(res.msg)
    }
  })
}

// 彈窗保存
const save = () => {
  // data.form有id就是更新，沒有就是新增
  data.form.id ? update() : add()
}

// 刪除
const handleDelete = (id) => {
  ElMessageBox.confirm('刪除後資料無法恢復，您確定刪除嗎?', '刪除確認', { type: 'warning' }).then(res => {
    request.delete('/course/deleteById/' + id).then(res => {
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

const loadCollege = () => {
  request.get('/college/selectAll').then(res => {
    if (res.code === '200') {
      data.collegeData = res.data
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const loadTeacher = () => {
  request.get('/teacher/selectAll').then(res => {
    if (res.code === '200') {
      data.teacherData = res.data
    } else {
      ElMessage.error(res.msg)
    }
  })
}

const choiceCourse = (row) => {
  let courseData = JSON.parse(JSON.stringify(row))
  courseData.studentId = data.user.id
  request.post('/choice/add', courseData).then(res => {
    if (res.code === '200') {
      ElMessage.success('恭喜你選課成功！')
      load()
    } else {
      ElMessage.error(res.msg)
    }
  })
}

load()
loadCollege()
loadTeacher()
</script>
