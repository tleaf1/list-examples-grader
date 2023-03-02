CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

##cp TestListExamples.java student-submission
cd student-submission
cp *.java ..
cd ..
if [ -f ListExamples.java ]
then
    echo 'ListExamples found'
else 
    echo 'ListExamples not found'
    set + e
    exit 1
fi 

javac -cp $CPATH *.java > compile-output.txt
if [ $? -eq 0 ]
then
    echo 'Compile success'
else 
    echo 'Failed to compile'
    echo compile-output.txt
fi 

java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt
NUMTESTS=`grep "Tests run: $x" test-output.txt | awk -F' ' '{print $NF}'`
RESULT=`grep "Failures: $y" test-output.txt | awk -F' ' '{print $NF}'`
PASS=`grep "OK ($z test)" test-output.txt | awk -F' ' '{print $NF}'`
GRADE=$((RESULT-NUMTESTS))
if [ $PASS > 0 ]
then 
    echo 'Congrats you have passed all the tests'
    echo 'Your current grade is 100%'
else 
    echo 'You have not passed all of the tests'
    echo 'Your current grade is' $GRADE/$NUMTESTS
fi 





