#!/bin/bash
read -p  "请输入要截取的日志节点,请选择输入：OA 或 PT 或 FW : "
echo "你输入的是：$REPLY"

echo "输入截取日志开始时间段(格式：年-月-日 时:分)：" 
echo "开始时间为: $input"
read input

echo "输入截取日志结束时间段(格式：年-月-日 时:分)：" 
echo "结束时间为: $input2"
read input2

echo "开始截取$REPLY日志，执行完毕请到/data/myansible拉取过滤后的日志。^_^"

if [ $REPLY = OA ];then

for i in node{03,04}
do
ssh root@$i > /dev/null 2>&1 << eeooff

sed -n '/$input/,/$input2/'p /data/logs/oa/web/instance-web/instance-web.log > /data/logs/oa/web/instance-web/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/oa/web/platformFormTool/platformFormTool.log > /data/logs/oa/web/platformFormTool/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/oa/web/rubikWeb/rubikWeb.log > /data/logs/oa/web/rubikWeb/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/oa/web/workflow-web/workflow-web.log > /data/logs/oa/web/workflow-web/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/oa/web/yxsynthetical-web/yxWeb.log > /data/logs/oa/web/yxsynthetical-web/lhp.log

sed -n '/$input/,/$input2/'p /data/tomcat-OA/logs/catalina.out > /data/tomcat-OA/logs/catalina.txt
sed -n '/$input/,/$input2/'p /data/tomcat-Yx/logs/catalina.out > /data/tomcat-Yx/logs/catalina.txt
sed -n '/$input/,/$input2/'p /data/tomcat-rubik/logs/catalina.out > /data/tomcat-rubik/logs/catalina.txt

exit
eeooff

done

ansible OAweb -m fetch -a 'src=/data/logs/oa/web/instance-web/lhp.log dest=/data/myansible'
ansible OAweb -m fetch -a 'src=/data/logs/oa/web/platformFormTool/lhp.log dest=/data/myansible'
ansible OAweb -m fetch -a 'src=/data/logs/oa/web/rubikWeb/lhp.log dest=/data/myansible'
ansible OAweb -m fetch -a 'src=/data/logs/oa/web/workflow-web/lhp.log dest=/data/myansible'
ansible OAweb -m fetch -a 'src=/data/logs/oa/web/yxsynthetical-web/lhp.log dest=/data/myansible'

ansible OAweb -m fetch -a 'src=/data/tomcat-OA/logs/catalina.txt dest=/data/myansible'
ansible OAweb -m fetch -a 'src=/data/tomcat-Yx/logs/catalina.txt dest=/data/myansible'
ansible OAweb -m fetch -a 'src=/data/tomcat-rubik/logs/catalina.txt dest=/data/myansible'


elif [ $REPLY = PT ];then

for j in node{05,06}
do
ssh root@$j > /dev/null 2>&1 << eeooff

sed -n '/$input/,/$input2/'p /data/logs/tomcat/attachmentTool/debug.log > /data/logs/tomcat/attachmentTool/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/tomcat/basicDataWeb/debug.log > /data/logs/tomcat/basicDataWeb/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/tomcat/msCenterWeb/debug.log >  /data/logs/tomcat/msCenterWeb/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/tomcat/timerTool/debug.log >  /data/logs/tomcat/timerTool/lhp.log

sed -n '/$input/,/$input2/'p /data/tomcat-PT/logs/catalina.out > /data/tomcat-PT/logs/catalina.txt
sed -n '/$input/,/$input2/'p /data/tomcat-B/logs/catalina.out > /data/tomcat-B/logs/catalina.txt
sed -n '/$input/,/$input2/'p /data/tomcat-M/logs/catalina.out > /data/tomcat-M/logs/catalina.txt

exit
eeooff

done

ansible PTweb -m fetch -a 'src=/data/logs/tomcat/attachmentTool/lhp.log dest=/data/myansible'
ansible PTweb -m fetch -a 'src=/data/logs/tomcat/basicDataWeb/lhp.log dest=/data/myansible'
ansible PTweb -m fetch -a 'src=/data/logs/tomcat/msCenterWeb/lhp.log dest=/data/myansible'


ansible PTweb -m fetch -a 'src=/data/tomcat-B/logs/catalina.txt dest=/data/myansible'
ansible PTweb -m fetch -a 'src=/data/tomcat-PT/logs/catalina.txt  dest=/data/myansible'
ansible PTweb -m fetch -a 'src=/data/tomcat-M/logs/catalina.txt  dest=/data/myansible'


elif [ $REPLY = FW ];then

for k in node{03..08}
do
ssh root@$k > /dev/null 2>&1 << eeooff

sed -n '/$input/,/$input2/'p /data/logs/provider/instance/instance-provider.log > /data/logs/provider/instance/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/provider/platform-form/platform-form-provider.log > /data/logs/provider/platform-form/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/provider/rubik/rubik-provider.log > /data/logs/provider/rubik/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/provider/workflow/workflow-provider.log > /data/logs/provider/workflow/lhp.log
sed -n '/$input/,/$input2/'p /data/logs/provider/yxsynthetical/yxsynthetical-provider.log > /data/logs/provider/yxsynthetical/lhp.log

exit
eeooff

done

ansible fw -m fetch -a 'src=/data/logs/provider/instance/lhp.log dest=/data/myansible'
ansible fw -m fetch -a 'src=/data/logs/provider/platform-form/lhp.log dest=/data/myansible'
ansible fw -m fetch -a 'src=/data/logs/provider/rubik/lhp.log dest=/data/myansible'
ansible fw -m fetch -a 'src=/data/logs/provider/workflow/lhp.log dest=/data/myansible'
ansible fw -m fetch -a 'src=/data/logs/provider/yxsynthetical/lhp.log dest=/data/myansible'

else
 
echo "输入有误，请重新执行脚本再输入！"

fi

echo "$REPLY 日志已经拉取完毕，请到/data/myansible/目录下查看和下载。"
