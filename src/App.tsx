import { useState } from "react";
import { FAKE_API_DATA, Section, Task } from "./data/data";

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
        <>
          <h2 key={section.title} className="text-xl font-bold">
            {section.title}
          </h2>
          <div className="h-10 w-full p-5">
            {Tasks({ tasks: section.tasks })}
          </div>
        </>
      ))}
    </>
  );
}

function App() {
  const [data] = useState(FAKE_API_DATA.guides);

  return (
    <>
      <aside className="flex w-[25%] flex-col bg-gray-200">
        <div className="flex basis-36 items-end justify-start p-6">
          <h1 className="text-3xl font-bold">{data[0].title}</h1>
        </div>
        <hr className="w-full basis-1 bg-gray-300"></hr>
        <div className="flex-auto p-10">
          {Sections({ sections: data[0].sections })}
        </div>
      </aside>
      <main className="w-[55%]"></main>
      <aside className="w-[20%] bg-gray-200"></aside>
    </>
  );
}

export default App;
