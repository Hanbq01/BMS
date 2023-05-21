# BMS-BookManagerSystem
Javaweb写的仓库管理系统，使用jsp+jdbc+JavaScript+css，没有框架，很简单的图书管理系统。是我的课程项目，没有技术亮点，不适合用来做毕设，过于简单。
主要页面都是用jsp语言写的，使用tomcat8.5和mysql8.0.32，修改数据库登录用户名密码在util.DButil.java
目前正在更新
### 0513 更新
初次提交，已经完成了管理员界面的大部分代码，所有代码纯手搓。JavaScript学的不太好，简单看了些教程和示例，
![image](https://github.com/Hanbq01/BMS/assets/127653499/0432f0b2-4f86-4550-b77a-1de24ed2db69)
![image](https://github.com/Hanbq01/BMS/assets/127653499/926f53f2-d0a9-4172-ba1e-92ef813e232a)
### 0514更新
本来想用ajax的方式实现点击修改按钮时显示修改界面，但是好像因为某些异步的方式很难实现😥😥😥，于是换了个思路，把所有的修改输入框写到页面中，使用JavaScript
的方法来控制显示和隐藏，感觉效果还不错，还是可以用的
![image](https://github.com/Hanbq01/BMS/assets/127653499/36b8265a-1f4f-4c33-9387-1e8619ca798b)
### 0515更新
改了一下JavaScript，加了一个js文件，把借阅记录和借阅人信息页面写好了，md，ajax没研究明白，使用ajax加载一个带ajax的页面会导致里边需要加载的那个打不开，于是换成了使用iframe加载页面，和我想要的效果差不多，也不错，等我再学一学看看怎么改回ajax
### 0516更新
新增添加图书功能，新增注册功能，至此，管理员功能基本完善，后续想到啥会继续添加，艹感觉自己还挺fw，还需要继续深入学习
![image](https://github.com/Hanbq01/BMS/assets/127653499/0b31fe3e-f809-48cb-9ac5-9f05988cc556)
![image](https://github.com/Hanbq01/BMS/assets/127653499/93db1cc0-1a87-45b5-82ac-e7396c52bb96)

# 0521 完成所有功能
数据库内容放到了sql文件夹中，里边有完整的数据库结构和样例数据
请自己看截图
图书管理界面，新增了查找功能
![image](https://github.com/Hanbq01/BMS/assets/127653499/1b46f9b8-6195-43db-8bb1-762cb03bb54b)

借阅人信息界面
![image](https://github.com/Hanbq01/BMS/assets/127653499/88e8c439-85ae-46bd-aed1-dd36dc0635be)

借阅记录界面，最后一栏判断是否过期，超过14天显示红色已过期，反之则显示绿色未过期
![image](https://github.com/Hanbq01/BMS/assets/127653499/aa7b10cb-2bb1-4c99-8024-f952f029c9e5)

普通用户借阅界面，复用了管理员界面的部分代码
![image](https://github.com/Hanbq01/BMS/assets/127653499/dc810147-0495-42a1-82d2-f5305fe9745c)

我的借阅记录，只显示当前登录用户的借阅记录
![image](https://github.com/Hanbq01/BMS/assets/127653499/3f0d9a35-75ed-4268-a06f-0d8c036ef1bb)

还有其他细节自己去看吧懒得写了

# 写在最后
本项目真的很简单，只是花样的使用JavaScript和iframe以及各种动态语句，没什么花样，自己的课程大项目练手用的，如果想当作一个高质量作业交上去请慎重

