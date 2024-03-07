type ContentBlockText = {
  id: string;
  type: "Text";
  content: string;
};

type ContentBlockAnswer = {
  id: string;
  type: "Text Answer";
  content: string;
};

type ContentBlockMultipleChoice = {
  id: string;
  type: "Multiple Choice";
  content: {
    content: string;
    checked: boolean;
  }[];
};

export type ContentBlock =
  | ContentBlockText
  | ContentBlockAnswer
  | ContentBlockMultipleChoice;

export type Task = {
  id: string;
  title: string;
  contentBlocks: ContentBlock[];
};

export type Section = {
  id: string;
  title: string;
  tasks: Task[];
};

export type Guide = {
  id: string;
  title: string;
  sections: Section[];
};

export const FAKE_API_DATA: { guides: Guide[] } = {
  guides: [
    {
      id: "54f31206-7e68-4c29-9d93-c242f0edb0cb",
      title: "My Guide",
      sections: [
        {
          id: "4c77e0ca-9cde-47d6-8b1e-bca3145805b6",
          title: "First Section",
          tasks: [
            {
              id: "9dd0d50c-8346-40fb-a025-fba0cd7483fc",
              title: "First Task",
              contentBlocks: [
                {
                  id: "030b42a8-6e4d-4ae4-9868-c7e82833d9ff",
                  type: "Text",
                  content: "",
                },
                {
                  id: "5a100827-3300-4652-a49b-816abbd8f405",
                  type: "Text Answer",
                  content: "",
                },
                {
                  id: "d73e6336-ab05-4634-91a1-09569cd9b827",
                  type: "Multiple Choice",
                  content: [
                    {
                      content: "",
                      checked: false,
                    },
                  ],
                },
              ],
            },
          ],
        },
      ],
    },
  ],
};
