/*
    I've opted for a relational database, instead of the non-relational counter
    part. I did this because for this specific problem I truly believe that the
    data integrity and security provided by a relational database can prevent
    big issues. 
    
    It's very important to keep track of the progress of each on the different
    guides provided by the platform, and relations help to make that mandatory
    for the data stored. This also helps with cleanup tasks, ensuring that the
    data that's not needed anymore it's deleted with things like ON CASCADE
    statements. 

    I think the security and integrity that relational databases provide to the
    data stored is invaluable for a domain that has so many connections between
    actors, like the one that WorkRamp has. 
*/

CREATE TABLE "Admin" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Learner" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Learner_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Guide" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Guide_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Section" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "position" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "guideId" TEXT NOT NULL,

    CONSTRAINT "Section_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "Task" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "position" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "sectionId" TEXT NOT NULL,
    "guideId" TEXT NOT NULL,

    CONSTRAINT "Task_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "ContentText" (
    "id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "position" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "taskId" TEXT NOT NULL,
    "guideId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,

    CONSTRAINT "ContentText_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "ContentTextInput" (
    "id" TEXT NOT NULL,
    "position" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "taskId" TEXT NOT NULL,
    "guideId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,

    CONSTRAINT "ContentTextInput_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "MultipleChoiceOption" (
    "id" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "isCorrectAnswer" BOOLEAN NOT NULL,
    "position" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "contentMultipleChoiceId" TEXT NOT NULL,
    "guideId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,
    "taskId" TEXT NOT NULL,

    CONSTRAINT "MultipleChoiceOption_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "ContentMultipleChoice" (
    "id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "position" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "taskId" TEXT NOT NULL,
    "guideId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,

    CONSTRAINT "ContentMultipleChoice_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "ContentImage" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "position" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "taskId" TEXT NOT NULL,
    "guideId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,

    CONSTRAINT "ContentImage_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "ContentVideo" (
    "id" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "position" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "taskId" TEXT NOT NULL,
    "guideId" TEXT NOT NULL,
    "sectionId" TEXT NOT NULL,

    CONSTRAINT "ContentVideo_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "GuidesAssignment" (
    "adminId" TEXT NOT NULL,
    "learnerId" TEXT NOT NULL,
    "guideId" TEXT NOT NULL,
    "completed" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GuidesAssignment_pkey" PRIMARY KEY ("adminId","learnerId","guideId")
);

CREATE TABLE "TextAnswers" (
    "learnerId" TEXT NOT NULL,
    "contentTextInputId" TEXT NOT NULL,
    "answer" TEXT NOT NULL,

    CONSTRAINT "TextAnswers_pkey" PRIMARY KEY ("learnerId","contentTextInputId")
);

CREATE TABLE "MultipleChoiceAnswers" (
    "learnerId" TEXT NOT NULL,
    "multipleChoiceOptionId" TEXT NOT NULL,
    "checked" BOOLEAN NOT NULL,

    CONSTRAINT "MultipleChoiceAnswers_pkey" PRIMARY KEY ("learnerId","multipleChoiceOptionId")
);

CREATE TABLE "TextsRead" (
    "textId" TEXT NOT NULL,
    "learnerId" TEXT NOT NULL,

    CONSTRAINT "TextsRead_pkey" PRIMARY KEY ("learnerId","textId")
);

CREATE TABLE "ImagesSeen" (
    "contentImageId" TEXT NOT NULL,
    "learnerId" TEXT NOT NULL,

    CONSTRAINT "ImagesSeen_pkey" PRIMARY KEY ("learnerId","contentImageId")
);

CREATE TABLE "VideosWatched" (
    "contentVideoId" TEXT NOT NULL,
    "learnerId" TEXT NOT NULL,

    CONSTRAINT "VideosWatched_pkey" PRIMARY KEY ("contentVideoId","learnerId")
);

CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

CREATE UNIQUE INDEX "Learner_email_key" ON "Learner"("email");

ALTER TABLE "Section" ADD CONSTRAINT "Section_guideId_fkey" FOREIGN KEY ("guideId") REFERENCES "Guide"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Task" ADD CONSTRAINT "Task_guideId_fkey" FOREIGN KEY ("guideId") REFERENCES "Guide"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Task" ADD CONSTRAINT "Task_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "Section"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentText" ADD CONSTRAINT "ContentText_guideId_fkey" FOREIGN KEY ("guideId") REFERENCES "Guide"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentText" ADD CONSTRAINT "ContentText_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "Section"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentText" ADD CONSTRAINT "ContentText_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentTextInput" ADD CONSTRAINT "ContentTextInput_guideId_fkey" FOREIGN KEY ("guideId") REFERENCES "Guide"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentTextInput" ADD CONSTRAINT "ContentTextInput_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "Section"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentTextInput" ADD CONSTRAINT "ContentTextInput_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "MultipleChoiceOption" ADD CONSTRAINT "MultipleChoiceOption_guideId_fkey" FOREIGN KEY ("guideId") REFERENCES "Guide"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "MultipleChoiceOption" ADD CONSTRAINT "MultipleChoiceOption_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "Section"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "MultipleChoiceOption" ADD CONSTRAINT "MultipleChoiceOption_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "MultipleChoiceOption" ADD CONSTRAINT "MultipleChoiceOption_contentMultipleChoiceId_fkey" FOREIGN KEY ("contentMultipleChoiceId") REFERENCES "ContentMultipleChoice"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentMultipleChoice" ADD CONSTRAINT "ContentMultipleChoice_guideId_fkey" FOREIGN KEY ("guideId") REFERENCES "Guide"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentMultipleChoice" ADD CONSTRAINT "ContentMultipleChoice_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "Section"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentMultipleChoice" ADD CONSTRAINT "ContentMultipleChoice_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentImage" ADD CONSTRAINT "ContentImage_guideId_fkey" FOREIGN KEY ("guideId") REFERENCES "Guide"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentImage" ADD CONSTRAINT "ContentImage_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "Section"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentImage" ADD CONSTRAINT "ContentImage_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentVideo" ADD CONSTRAINT "ContentVideo_guideId_fkey" FOREIGN KEY ("guideId") REFERENCES "Guide"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentVideo" ADD CONSTRAINT "ContentVideo_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "Section"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ContentVideo" ADD CONSTRAINT "ContentVideo_taskId_fkey" FOREIGN KEY ("taskId") REFERENCES "Task"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "GuidesAssignment" ADD CONSTRAINT "GuidesAssignment_adminId_fkey" FOREIGN KEY ("adminId") REFERENCES "Admin"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "GuidesAssignment" ADD CONSTRAINT "GuidesAssignment_learnerId_fkey" FOREIGN KEY ("learnerId") REFERENCES "Learner"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "GuidesAssignment" ADD CONSTRAINT "GuidesAssignment_guideId_fkey" FOREIGN KEY ("guideId") REFERENCES "Guide"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "TextAnswers" ADD CONSTRAINT "TextAnswers_learnerId_fkey" FOREIGN KEY ("learnerId") REFERENCES "Learner"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "TextAnswers" ADD CONSTRAINT "TextAnswers_contentTextInputId_fkey" FOREIGN KEY ("contentTextInputId") REFERENCES "ContentTextInput"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "MultipleChoiceAnswers" ADD CONSTRAINT "MultipleChoiceAnswers_learnerId_fkey" FOREIGN KEY ("learnerId") REFERENCES "Learner"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "MultipleChoiceAnswers" ADD CONSTRAINT "MultipleChoiceAnswers_multipleChoiceOptionId_fkey" FOREIGN KEY ("multipleChoiceOptionId") REFERENCES "MultipleChoiceOption"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "TextsRead" ADD CONSTRAINT "TextsRead_textId_fkey" FOREIGN KEY ("textId") REFERENCES "ContentText"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "TextsRead" ADD CONSTRAINT "TextsRead_learnerId_fkey" FOREIGN KEY ("learnerId") REFERENCES "Learner"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ImagesSeen" ADD CONSTRAINT "ImagesSeen_contentImageId_fkey" FOREIGN KEY ("contentImageId") REFERENCES "ContentImage"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ImagesSeen" ADD CONSTRAINT "ImagesSeen_learnerId_fkey" FOREIGN KEY ("learnerId") REFERENCES "Learner"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "VideosWatched" ADD CONSTRAINT "VideosWatched_contentVideoId_fkey" FOREIGN KEY ("contentVideoId") REFERENCES "ContentVideo"("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "VideosWatched" ADD CONSTRAINT "VideosWatched_learnerId_fkey" FOREIGN KEY ("learnerId") REFERENCES "Learner"("id") ON DELETE CASCADE ON UPDATE CASCADE;
