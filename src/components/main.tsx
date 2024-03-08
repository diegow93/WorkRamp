import { Section, Task } from "../data/data";

export function Tasks(props: { tasks: Task[]; selectedTask: Task }) {
  return (
    <>
      <ul>
        {props.tasks.map((task) => (
          <div key={task.id}>
            <li
              className={`list-disc font-bold ${!props.selectedTask ? "" : " marker:text-blue-500"}`}
            >
              {task.title}
            </li>
            {!props.selectedTask ? null : (
              <div className="absolute right-[50%] top-[50%] h-full w-full translate-x-[50%] translate-y-[-50%] rounded bg-blue-500 opacity-20"></div>
            )}
          </div>
        ))}
      </ul>
    </>
  );
}

export function Sections(props: { sections: Section[]; selectedTask: Task }) {
  return (
    <>
      {props.sections.map((section) => (
        <div key={section.id} className="flex flex-col gap-4">
          <h2 className="text-xl font-bold">{section.title}</h2>
          <div className="relative flex h-10 w-full items-center p-5">
            <Tasks tasks={section.tasks} selectedTask={props.selectedTask} />
          </div>
          <button className="flex h-full w-7 items-center justify-center rounded-full border-2 border-gray-400">
            <span className="font-bold text-blue-500">+</span>
          </button>
        </div>
      ))}
    </>
  );
}

export function ContentButton(props: {
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
