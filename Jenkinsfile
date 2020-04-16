
node {
    PR_NAME = env.CHANGE_BRANCH.replace("/","%2F")
    build job:
        'couchbase-lite-android-ci',
        parameters: [
            string(name:'PR_REPO_URL', value:'git@github.com:couchbase/couchbase-lite-java-ce-root.git'),
            string(name:'PR_BRANCH', value:"${env.CHANGE_BRANCH}"),
            string(name:'PR_NAME', value:"${env.CHANGE_ID}-${PR_NAME}")
        ]
}





