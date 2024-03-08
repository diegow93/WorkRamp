import { useEffect, useState } from "react";
import {
  Guide,
  Section,
  Task,
  addAnswer,
  addMultipleChoice,
  addText,
  deleteContentBlock,
  getGuides,
} from "./data/data";
import inputLogo from "./assets/input-svgrepo-com.svg";
import textLogo from "./assets/text-align-left-svgrepo-com.svg";
import multipleChoiceLogo from "./assets/list-with-check-boxes-svgrepo-com.svg";
import { MultipleChoice, Text, TextAnswer } from "./components/contentBlocks";

function Tasks(props: { tasks: Task[] }) {
  return (
    <>
      <ul>
        {props.tasks.map((task) => (
          <li key={task.id} className="list-disc font-bold">
            {task.title}
          </li>
        ))}
      </ul>
    </>
  );
}

function Sections(props: { sections: Section[] }) {
  return (
    <>
      {props.sections.map((section) => (
        <div key={section.id}>
          <h2 className="text-xl font-bold">{section.title}</h2>
          <div className="h-10 w-full p-5">
            <Tasks tasks={section.tasks} />
          </div>
        </div>
      ))}
    </>
  );
}

function ContentButton(props: {
  logo: string;
  text: string;
  handleOnClick: () => Promise<void>;
}) {
  return (
    <button
      onClick={() => void props.handleOnClick()}
      className="flex h-14 w-full items-center justify-start gap-3 rounded border border-gray-300 bg-white px-5"
    >
      <div className="flex h-full max-w-5 items-center justify-center">
        <img src={props.logo}></img>
      </div>
      <span>{props.text}</span>
    </button>
  );
}

function App() {
  const [data, setData] = useState<{ guides: Guide[] } | null>(null);
  const [selectedTask, setSelectedTask] = useState<Task | null>(null);

  useEffect(() => {
    void (async () => {
      const newData = await getGuides();
      setData(newData);
      setSelectedTask(newData?.guides[0].sections[0].tasks[0]);
    })();
  }, []);

  return !data || !selectedTask ? null : (
    <>
      <aside className="flex w-[25%] flex-col bg-gray-200">
        <div className="flex basis-36 items-end justify-start p-6">
          <h1 className="text-3xl font-bold">{data.guides[0].title}</h1>
        </div>

        <hr className="w-full basis-1 bg-gray-300"></hr>

        <div className="flex-auto p-10">
          <Sections sections={data.guides[0].sections} />
        </div>
      </aside>

      <main className="flex w-[55%] flex-col justify-start gap-8 overflow-auto bg-white p-8">
        <h3 className="text-2xl">{selectedTask.title}</h3>
        <article className="flex h-full w-full flex-col justify-start gap-8 px-10">
          {selectedTask.contentBlocks.map((contentBlock) => {
            switch (contentBlock.type) {
              case "Text":
                return (
                  <Text
                    key={contentBlock.id}
                    contentBlockText={contentBlock}
                    handleDelete={async () => {
                      await deleteContentBlock(contentBlock.id);
                      setData(await getGuides());
                    }}
                  />
                );
              case "Text Answer":
                return (
                  <TextAnswer
                    key={contentBlock.id}
                    contentBlockAnswer={contentBlock}
                    handleDelete={async () => {
                      await deleteContentBlock(contentBlock.id);
                      setData(await getGuides());
                    }}
                  />
                );
              case "Multiple Choice":
                return (
                  <MultipleChoice
                    key={contentBlock.id}
                    contentBlockMultipleChoice={contentBlock}
                    handleDelete={async () => {
                      await deleteContentBlock(contentBlock.id);
                      setData(await getGuides());
                    }}
                  />
                );
              default:
                break;
            }
          })}
        </article>
      </main>

      <aside className="flex w-[20%] flex-col justify-start gap-4 bg-gray-200 p-10">
        <h2 className="text-xl font-bold">Add Content</h2>
        <ContentButton
          logo={textLogo}
          text={"Text"}
          handleOnClick={async () => {
            await addText();
            setData(await getGuides());
          }}
        />
        <ContentButton
          logo={inputLogo}
          text={"Text Answer"}
          handleOnClick={async () => {
            await addAnswer();
            setData(await getGuides());
          }}
        />
        <ContentButton
          logo={multipleChoiceLogo}
          text={"Multiple Choice"}
          handleOnClick={async () => {
            await addMultipleChoice();
            setData(await getGuides());
          }}
        />
      </aside>
    </>
  );
}

export default App;
