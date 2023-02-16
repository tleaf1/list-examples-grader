CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cp TestListExamples.java student-submission
cd student-submission
if [ -f ListExamples.java ]
then
    echo 'ListExamples found'
else 
    echo 'ListExamples not found'
    set + e
    exit 1
fi 

cd ..
javac -cp $CPATH student-submission/*.java > compile-output.txt
if [ $? -eq 0 ]
then
    echo 'Compile success'
else 
    echo 'Failed to compile'
    echo compile-output.txt
fi 
cd student-submission
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > test-output.txt
RESULT=`grep "Failures: $z" test-output.txt | awk -F' ' '{print $NF}'`
NUMTESTS=`grep "Tests run: $z" test-output.txt | awk -F' ' '{print $NF}'`
GRADE=$((RESULT-NUMTESTS))
if [ $RESULT -eq 0 ]
then 
    echo 'Congrats you have passed all the tests'
    echo 'Your current grade is 100%'
else 
    echo 'You have not passed all of the tests'
    echo 'Your current grade is' $GRADE/$NUMTESTS
fi 





