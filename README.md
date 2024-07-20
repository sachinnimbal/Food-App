## 💻 Tech Used:
![Java](https://img.shields.io/badge/java-%23ED8B00.svg?style=flat&logo=openjdk&logoColor=white) 
![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=flat&logo=html5&logoColor=white) 
![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=flat&logo=css3&logoColor=white) 
![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=flat&logo=javascript&logoColor=%23F7DF1E) 
![MySQL](https://img.shields.io/badge/mysql-%2300000f.svg?style=flat&logo=mysql&logoColor=white) 

## Step 1: Clone the Repository
Open a terminal or command prompt.
Navigate to the directory where you want to clone the repository.
Run the following command to clone the repository:
```bash
git clone https://github.com/sachinnimbal/Food-Delivery-Web-App.git
```

## Step 2: Import the Database into MySQL Workbench
1. Open MySQL Workbench.
2. Connect to your MySQL server.
3. Create a new database for the application and name it `foodiedelightdb`.
4. Click on the `Server` menu and select `Data Import`.
5. Choose the `Import from Self-Contained File` option.
6. Browse and select the SQL file from the cloned repository (usually located in a directory like `sql/` or similar).
7. Select the `foodiedelightdb` as the target database.
8. Click `Start Import` to import the database schema and data.

## Step 3: Open the Project in Eclipse
1. Open Eclipse IDE.
2. Go to `File` > `Import`.
3. Select `Maven` > `Existing Projects into Workspace` and click `Next`.
4. Browse to the directory where you cloned the repository and select it.
5. Click `Finish` to import the project into Eclipse.

## Step 4: Update Database Username and Password
1. In Eclipse, navigate to the `src/main/java/com/foodiedelight/util` directory.
2. Open the `DBConnectionUtil.java` file.
3. Update the `USERNAME` and `PASSWORD` fields with your MySQL username and password:

```java
private static final String USERNAME = "your_mysql_username";
private static final String PASSWORD = "your_mysql_password"; 
```

4. Save the changes.

## Step 5: Run the Application on a Server
1. In Eclipse, right-click on the project in the Project Explorer.
2. Select `Run As` > `Maven Build...`.
3. In the Goals field, enter `clean install` and click `Run` to build the project.
4. After the build is successful, right-click on the project again.
5. Select `Run As` > `Run on Server`.
6. Choose the server you want to run the application on (e.g., Apache Tomcat).
7. Click `Finish` to deploy and start the application on the server.

## Step 6: Access the Application
1. Open a web browser.
2. Navigate to `http://localhost:8080/Food-Delivery-Web-App` (or the appropriate URL based on your server configuration) to access the application.

## Admin Login
- **Username:** sknsachin
- **Password:** Skn1631$$

## Restaurant Login
- **Username:** sachin
- **Password:** Skn1631$4

## User Login
- Create New Account

## Delivery Agent Login
- Create New Account & Login as Admin to assign this account the role of DeliveryAgent

## Project Screenshots

![FoodieDelight Desktop Demo](./FoodAppImages/Project1.png "Desktop Demo")

![FoodieDelight Desktop Demo](./FoodAppImages/Project2.png "Desktop Demo")
