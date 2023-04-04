## Google Cloud Build SMTP notifier EDITED
### [Original article](https://devopsquare.com/cloud-build-easy-way-to-receive-build-notifications-through-email-aed6768d2b20) 
### [Original repository](https://github.com/mukarramishaq/cloud-build-notifications)


## Changes:
- Removed parts related to notifications in __Google Chat Room__.
- Updated dependencies to latest versions as of March 2023.
- Updated version of __Node__ base image in __Dockerfile__ to 19.
- Wrote a __cloudbuild.yaml__ file to make it possible to deploy notifier's service via GCB.

## How it works:
When a build starts in **GCB**, **Pub/Sub** generates a notification for **EventARC**, what then triggers the notification service on **Google Cloud Run**. The process in GCR collects information about running building process and then send an email to recipents in the list. By default, the notifier can send theree email-notifications: regarding started building process, one in case of success and another in case of failure.

## How to apply to your project on Google Cloud Platform:
1. Add roles **Cloud Build Editor**, **Cloud Build Service Account**, **Cloud Run Admin**, **Service Account User** to accout __PROJECT-ID__@cloudbuild.gserviceaccount.com. And role **Eventarc Admin** to account __PROJECT-ID__-compute@cloudbuild.gserviceaccount.com.
2. Create EventARC trigger
3. Create Pub/Sub subscribtion
4. Build the process in GCR, using provided files. You can both create an image, using provided Dockerfile, locally and upload it later to Artifact Registry or Container Registry, or deploy a service via GCB, using provided YAML file **(remember to add project name, image name and  to the YAML)**_

## Files
- Configuration file with list of recipients, SMTP server and creds for it: **.env**
- File with list of exports of filenames: **/src/utils/constants.ts**
- File with filed what will be included in a email: **/src/clients/Client.ts**
- File with body of a email: **/src/clients/Mail/SMTPClient.ts**

## Issuses:
- Since I'm not into TypeScript, I couldn't add possibility to retrieve username and password of SMTP-server via Secret Manager of GCP. Following documentation by Google describes how to do it: [Secret Manager: Node.js Client](https://cloud.google.com/nodejs/docs/reference/secret-manager/latest). Yon use app password to minimize attack surface.
- I can't say for sure how to customize email that will be send out. But still, email seems to has enough info regarding.
- You can use BASH-script __setup.sh__ from the original repository to ease installation process. If the script won't successfully setup notifier -- it is fine, since you will have ready-to-go trigger in EventARC, subscription in Pub/Sub and a service in GCR (you can just add your image to GCR from Registry and run it).  
