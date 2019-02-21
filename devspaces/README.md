# changelog.com Development with DevSpaces 

## DF DevSpaces CLI Installation

You can download the setup file in [this link](https://www.devspaces.io/devspaces/download) and follow the install steps [here](https://support.devspaces.io/article/22-devspaces-client-installation).

* To download the DevSpaces CLI, you need to log in using your GitHub account.

## DF DevSpaces CLI Usage

After installation, you can use DevSpaces CLI by running `devspaces` command in the command line. It will show all the actions that you can do with DevSpaces.

### Start a new DevSpace for changelog.com

Please, follow these steps to create a new DevSpace and build the changelog.com project inside it:

1. Move to `devspaces` folder. This folder contains all resources that are needed to create the DevSpace.

        cd devspaces

1. Create the DevSpace by running the following command. A new window will be shown with the build status.

        devspaces create
    
    * The notification system will show a message when the build is finished. Then the validation process starts (it takes at least 2 minutes).

1. When the validation process is finished, you can start the DevSpace by running the following command. 

        devspaces start changelog

    * The notification system will inform when the start is finished.

1. You can enter the created DevSpace by running the following command. 

        devspaces exec changelog

### Build and Run changelog.com

1. First, you need the source code inside the container. There are two approaches to get that: clone the repository inside the container (a) or bind the local repository with the container (b). 

    a. To clone the repository inside the container you can run the following command:

                git clone https://github.com/trilogy-group/changelog.com.git

    * If you want to clone the repository inside the `/data` folder you will need first to clean it (**CAUTION: if it is bonded, the files in local environment will be deleted too**):

                cd /data
                rm -rf .*
                rm -rf *
                git clone https://github.com/trilogy-group/changelog.com.git .

    b. To bind a folder to the created and started DevSpace, it is needed to follow the steps below:

    * Make sure that the DevSpace is `Running` using the `devspaces ls` command.
    * With a running DevSpace, move to the root folder of the repository in the local machine.
    * Run the below command to bind the current folder:

                devspaces bind changelog

    * Wait to get all files synced. When you get the sync up to date, everything that is changed, deleted or created inside the local folder or in the `/data` folder inside the container will be synced. The sync is bidirectional. 
    * **Note:** If you want to stop the bind, just move to the bonded folder and run the command:

                devspaces unbind changelog
                
1. To build and run changelog.com inside the DevSpace you need first to set some environment configurations. To facilitate it, there is a script inside the `/opt` folder called `env_config.sh`. This script receives two args: the hostname of the current DevSpace and the bonded port:

        /opt/env_config.sh changelog.otaviocx.devspaces.io 56434

    * To get the correct hostname and port, you need to run the following command in a local terminal:
                
                devspaces info changelog

    * The command above will show the details about the changelog DevSpace. There are some URLs that exposes ports of the container. You need to get the hostname (that is the same for all ports) and the bonded port for port `4000`.

1. With the environment set up, you can now build the project. To do that you need to install the assets and deps and compile the source code:

        mix do deps.get, compile
        cd assets && yarn install

1. You can also run the automated tests. To do that, you need to change the environment to `test`, create the database for tests, run the migrations and then run the tests:

        MIX_ENV=test mix do ecto.create, ecto.migrate, test

1. To run the project, you need to create the database, run the migrations and start the server by running the following command:

        mix do ecto.create, ecto.migrate, phx.server

    * To access the running server, you can open in a web browser the same hostname and port that you used with the `dev_config.sh` script. There is also a PostgreSQL inside the container that you can access using `postgres` as the username and password.
