#!/bin/bash

SRC_NAME="swifttemplate"

TMP_PATH=`pwd`
SRC_PATH=$(cd `dirname $0`/../$SRC_NAME; pwd)
cd $TMP_PATH

SRC_NAMESPACE="TMPJ"
SRC_DAY="15/3/11"
SRC_YEAR="2015年"

PROJECT_PATH="$1/$2"
PROJECT_NAME=$2
NAMESPACE=$3
CURRENTDAY=`date +%Y/%-m/%-d`
CURRENTYEAR=`date +%Y年`

createFile()
{
	echo "creating project files at : $PROJECT_PATH ..."
	cp -R "$SRC_PATH" "$PROJECT_PATH"
	if [ ! $? -eq 0 ];then
		exit 1
	fi
	echo "create files ok"
	echo "renaming files ..."
	mv "$PROJECT_PATH/$SRC_NAME" "$PROJECT_PATH/$PROJECT_NAME"
	mv "$PROJECT_PATH/$PROJECT_NAME/$SRC_NAME.h" "$PROJECT_PATH/$PROJECT_NAME/$PROJECT_NAME.h"
	mv "$PROJECT_PATH/$SRC_NAME.xcodeproj" "$PROJECT_PATH/$PROJECT_NAME.xcodeproj"
	mv "$PROJECT_PATH/$PROJECT_NAME/classes/databases/$SRC_NAME.xcdatamodeld" "$PROJECT_PATH/$PROJECT_NAME/classes/databases/$PROJECT_NAME.xcdatamodeld"
	echo "rename files ok"
    	echo "copying .gitignore ..."
    	cp  "$SRC_PATH/../.gitignore" "$PROJECT_PATH"
    	echo "copying .gitignore ok!"
	echo "removing redundancy files ... "
	rm -rf "$PROJECT_PATH/$PROJECT_NAME.xcodeproj/xcuserdata"
	rm -rf "$PROJECT_PATH/$PROJECT_NAME.xcodeproj/xcshareddata"
	rm -rf "$PROJECT_PATH/$PROJECT_NAME.xcodeproj/project.xcworkspace/xcuserdata"
	rm -rf "$PROJECT_PATH/$PROJECT_NAME.xcodeproj/project.xcworkspace/xcshareddata"
	echo "remove files ok"
}

renameFile()
{
  for file in `ls $1`
      do
        if [ -d $file ]
        then
        	if [ $file != "Library" ]
         	then
    	      cd $file
            renameFile "."
            cd ..
          fi
        elif [ -f $file ]
        then
        	sed -i '' "s/${SRC_NAME}/${PROJECT_NAME}/g" $file
          sed -i '' "s/${SRC_NAMESPACE}/${NAMESPACE}/g" $file
          sed -i '' "s:${SRC_DAY}:${CURRENTDAY}:g" $file
	  sed -i '' "s:${SRC_YEAR}:${CURRENTYEAR}:g" $file
          mv $file ${file/${SRC_NAMESPACE}/$NAMESPACE}
       fi
	   done               
}
start()
{
	if [ -f $PROJECT_PATH ];then
		echo "target project src_root:$PROJECT_PATH already exsit !!"
		exit 1
	fi
	createFile
	cd $PROJECT_PATH
	if [ $? -ne 0 ];then
		echo "create project $PROJECT_PATH failed !!"
		exit 1
	fi
	echo "replacing symbools ..."
	renameFile "."
	echo "replace symbools ok"
	#-----------------------------------------submodule mode------------------
	#echo "creating git storage ..."
	#git init
	#echo "create git storage ok"
	#echo "add submodule Library/shared"
	#git submodule add git@www.gentrabbit.com:supertext/shared.git Library/shared
	#echo "dependence add completed!!"
	#----------------------------------------------------------------------------
	echo "now you can use new project :$PROJECT_PATH/$PROJECT_NAME.xcodeproj"
	open "$PROJECT_PATH/$PROJECT_NAME.xcodeproj"
}

start
