#!/bin/zsh
#
# I built this on a mac using JDK 19. It's pretty generic, though; any linux-based machine running any JDK after 9 should be
# able to just run this.

# the root of all modules' code
MODULE_SRC=src
# where compiled modules should end up; this is the "modulepath" for .class files
MODULE_CLASSES=classes

# the name of the module we're going to build. This script only builds this one module
MODULE_NAME=com.jrandrews.adder

# the entry point of our demo module.
MAIN=com.jrandrews.adder.Main

# the directory containing our jlink output
SMALLER_JRE=demoJre
# the command (to be found in ${SMALLER_JRE}/bin) that will run our ${MAIN} program
LAUNCHER=runAdder

echo "build: javac --module ${MODULE_NAME} --module-source-path ${MODULE_SRC} -d ${MODULE_CLASSES}"
javac --module ${MODULE_NAME} --module-source-path ${MODULE_SRC} -d ${MODULE_CLASSES}

# the following runs the module code using the full JVM. Think of this like an integration test.

echo
echo "build: java --module-path ${MODULE_CLASSES} --module ${MODULE_NAME}/${MAIN} adding some numbers: 1 3 5 7 9"
java --module-path ${MODULE_CLASSES} --module ${MODULE_NAME}/${MAIN} adding some numbers: 1 3 5 7 9

# jlink won't overwrite, so let's make sure the output directory doesn't exist
rm -rf ${SMALLER_JRE} > /dev/null 2>&1

# now build the very small JVM needed to run this "hello world"-style module.

echo
echo "build: jlink --module-path ${MODULE_CLASSES} --add-modules ${MODULE_NAME},java.base --launcher ./${LAUNCHER}=${MODULE_NAME}/${MAIN} --output ${SMALLER_JRE}"
jlink --module-path ${MODULE_CLASSES} --add-modules ${MODULE_NAME},java.base --launcher ./${LAUNCHER}=${MODULE_NAME}/${MAIN} --output ${SMALLER_JRE}

# the launcher built by jlink is just a shell script; this lists its contents to the console

echo
echo "build: cat ${SMALLER_JRE}/bin/${LAUNCHER}"
cat ${SMALLER_JRE}/bin/${LAUNCHER}

# and run the final jlink result. You could move this ${SMALLER_JRE} directory anywhere and this command would still work.

echo
echo "build: ${SMALLER_JRE}/bin/${LAUNCHER} adding different numbers: 8 13 5 -17 12"
${SMALLER_JRE}/bin/${LAUNCHER} adding different numbers: 8 13 5 -17 12
