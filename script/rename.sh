#!/bin/bash
SRC_ROOT=$1
SRC_CLASSNAME=$2
TARGET_CLASSNAME=$3

renameClass()
{
  for file in `ls $1`
	   do
        if [ -d $file ]
        then
        	if [ $file != "Library" ] && [ $file != "xcuserdata" ] && [ $file != "xcshareddata" ]
         	then
    	      cd $file
            renameClass "."
            cd ..
          fi
        elif [ -f $file ]
        then
        	sed -i '' "s/${SRC_CLASSNAME}/${TARGET_CLASSNAME}/g" $file
          mv $file ${file/${SRC_CLASSNAME}/$TARGET_CLASSNAME}
        fi
	   done
}
start()
{
	cd $SRC_ROOT
	
	if [ $? -ne 0 ];then
		echo "project src_root :$SRC_ROOT don't exsit"
		exit 1
	fi
	
	if [ ${SRC_ROOT##*/} == $SRC_CLASSNAME ];then
		echo "can not change the target class name!!"
		exit 1
	fi
	
	if [ $TARGET_CLASSNAME == $SRC_CLASSNAME ];then
		echo "no neet to rename the the same calss name"
		exit 0
	fi
	renameClass "."
}
start