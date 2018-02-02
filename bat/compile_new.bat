cd C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\src
javac pocket\beans\*.java

javac pocket\utility\*.java

javac pocket\views\*.java

javac pocket\dao\*.java

javac pocket\controllers\*.java

xcopy C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\src\pocket\controllers\*.class C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\classes\pocket\controllers

xcopy C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\src\pocket\beans\*.class C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\classes\pocket\beans

xcopy C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\src\pocket\utility\*.class C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\classes\pocket\utility

xcopy C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\src\pocket\views\*.class C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\classes\pocket\views

xcopy C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\src\pocket\dao\*.class C:\apache-tomcat-7.0.81\webapps\Pocket\WEB-INF\classes\pocket\dao







