/* empty css                *//* empty css                    *//* empty css               *//* empty css               *//* empty css                *//* empty css              */import{r as u}from"./request-585909c7.js";import{r as y,o as c,c as E,d,e as a,w as p,p as x,s as C,C as S,D as h,m,g as k,h as z,H as I,E as g,I as T}from"./index-445d3c97.js";const v={class:"card",style:{"margin-bottom":"5px"}},B={class:"card",style:{"margin-bottom":"5px"}},D={class:"card"},R={__name:"Choice",setup(V){const e=y({user:JSON.parse(localStorage.getItem("system-user")||"{}"),pageNum:1,pageSize:10,total:0,form:{},tableData:[],name:null}),i=()=>{let s=null,t=null;e.user.role==="TEACHER"&&(s=e.user.id),e.user.role==="STUDENT"&&(t=e.user.id),u.get("/choice/selectPage",{params:{pageNum:e.pageNum,pageSize:e.pageSize,name:e.name,teacherId:s,studentId:t}}).then(o=>{var r,l;e.tableData=(r=o.data)==null?void 0:r.list,e.total=(l=o.data)==null?void 0:l.total})},_=s=>{I.confirm("取消後可能再也選不到這門課了哦?","取消選課",{type:"warning"}).then(t=>{u.delete("/choice/deleteById/"+s).then(o=>{o.code==="200"?(i(),g.success("操作成功")):g.error(o.msg)})}).catch(t=>{})},b=()=>{e.name=null,i()};return i(),(s,t)=>{const o=x,r=C,l=T,f=S,N=h;return c(),E("div",null,[d("div",v,[a(o,{modelValue:e.name,"onUpdate:modelValue":t[0]||(t[0]=n=>e.name=n),style:{width:"300px","margin-right":"10px"},placeholder:"請輸入課程名稱查詢"},null,8,["modelValue"]),a(r,{type:"primary",onClick:i},{default:p(()=>t[3]||(t[3]=[m("查詢")])),_:1}),a(r,{type:"info",style:{margin:"0 10px"},onClick:b},{default:p(()=>t[4]||(t[4]=[m("重置")])),_:1})]),d("div",B,[a(f,{data:e.tableData,stripe:""},{default:p(()=>[a(l,{label:"課程名稱",prop:"name"}),a(l,{label:"授課教師",prop:"teacherName"}),a(l,{label:"選課學生",prop:"studentName"}),e.user.role==="STUDENT"?(c(),k(l,{key:0,label:"操作",align:"center",width:"160"},{default:p(n=>[a(r,{type:"danger",onClick:w=>_(n.row.id)},{default:p(()=>t[5]||(t[5]=[m("取消選課")])),_:2},1032,["onClick"])]),_:1})):z("",!0)]),_:1},8,["data"])]),d("div",D,[a(N,{background:"",layout:"prev, pager, next","page-size":e.pageSize,"onUpdate:pageSize":t[1]||(t[1]=n=>e.pageSize=n),"current-page":e.pageNum,"onUpdate:currentPage":t[2]||(t[2]=n=>e.pageNum=n),total:e.total},null,8,["page-size","current-page","total"])])])}}};export{R as default};