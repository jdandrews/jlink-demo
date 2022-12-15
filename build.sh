#!/bin/zsh
#
MODULE_SRC=src
MODULE_CLASSES=classes

MODULE_NAME=com.jrandrews.adder

MAIN=com.jrandrews.adder.Main

SMALLER_JRE=demoJre
LAUNCHER=runAdder

echo "build: javac --module ${MODULE_NAME} --module-source-path ${MODULE_SRC} -d ${MODULE_CLASSES}"
javac --module ${MODULE_NAME} --module-source-path ${MODULE_SRC} -d ${MODULE_CLASSES}

echo
echo "build: java --module-path ${MODULE_CLASSES} --module ${MODULE_NAME}/${MAIN}"
java --module-path ${MODULE_CLASSES} --module ${MODULE_NAME}/${MAIN}

rm -rfq ${SMALLER_JRE}

echo
echo "build: jlink --module-path ${MODULE_CLASSES} --add-modules ${MODULE_NAME},java.base --launcher ./${LAUNCHER}=${MODULE_NAME}/${MAIN} --output ${SMALLER_JRE}"
jlink --module-path ${MODULE_CLASSES} --add-modules ${MODULE_NAME},java.base --launcher ./${LAUNCHER}=${MODULE_NAME}/${MAIN} --output ${SMALLER_JRE}

echo
echo "build: cat ${SMALLER_JRE}/bin/${LAUNCHER}"
cat ${SMALLER_JRE}/bin/${LAUNCHER}

echo
echo "build: ${SMALLER_JRE}/bin/${LAUNCHER}"
${SMALLER_JRE}/bin/${LAUNCHER}
