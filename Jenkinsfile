pipeline {
    agent {
        node {
            label 'master'
        }
    }
    options { quietPeriod(600) }
    parameters { 
        string(name: 'IMAGE_NAME', defaultValue: 'jmeter-master', description: '构建后的 Docker 镜像名称')
        string(name: 'IMAGE_FREFIX', defaultValue: 'registry.cn-qingdao.aliyuncs.com/metersphere', description: '构建后的 Docker 镜像带仓库名的前缀')
    }
    stages {
        stage('Docker build & push Base Image') {
            steps {
                sh "docker build -t jmeter-base:latest ./jmeter-base/"
                sh "docker tag jmeter-base:latest ${IMAGE_FREFIX}/jmeter-base:latest"
                sh "docker push ${IMAGE_FREFIX}/jmeter-base:latest"
            }
        }
        stage('Docker build & push') {
            steps {
                sh "docker build --build-arg IMAGE_PREFIX=${IMAGE_FREFIX} -t ${IMAGE_NAME}:\${TAG_NAME:-\$BRANCH_NAME} ./jmeter-master/"
                sh "docker tag ${IMAGE_NAME}:\${TAG_NAME:-\$BRANCH_NAME} ${IMAGE_FREFIX}/${IMAGE_NAME}:\${TAG_NAME:-\$BRANCH_NAME}"
                sh "docker push ${IMAGE_FREFIX}/${IMAGE_NAME}:\${TAG_NAME:-\$BRANCH_NAME}"
            }
        }
    }
    post('Notification') {
        always {
            sh "echo \$WEBHOOK\n"
            withCredentials([string(credentialsId: 'wechat-bot-webhook', variable: 'WEBHOOK')]) {
                qyWechatNotification failSend: true, mentionedId: '', mentionedMobile: '', webhookUrl: "$WEBHOOK"
            }
        }
    }
}
