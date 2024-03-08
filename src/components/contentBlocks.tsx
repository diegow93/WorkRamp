import {
  ContentBlockAnswer,
  ContentBlockMultipleChoice,
  ContentBlockText,
} from "../data/data";
import closeLogo from "../assets/close-md-svgrepo-com.svg";
import textLogo from "../assets/text-align-left-svgrepo-com.svg";
import inputLogo from "../assets/input-svgrepo-com.svg";
import multipleChoiceLogo from "../assets/list-with-check-boxes-svgrepo-com.svg";
import { ChangeEvent, useState } from "react";

export function Text(props: {
  contentBlockText: ContentBlockText;
  handleDelete: () => Promise<void>;
}) {
  const [inputValue, setInputValue] = useState(props.contentBlockText.content);

  const handleChange = (e: ChangeEvent<HTMLTextAreaElement>) => {
    setInputValue(e.target.value);
  };

  return (
    <section className="flex h-auto w-full flex-col rounded border border-gray-300 bg-white first:border-b">
      <div className="w-full basis-11 border-b border-gray-300 px-4 py-2">
        <div className="flex h-full w-full justify-between">
          <div className="flex h-full items-center gap-2">
            <div className="flex h-7 w-7 items-center justify-center">
              <img src={textLogo}></img>
            </div>
            <span className="text-sm">TEXT</span>
          </div>

          <button
            className="basis-4"
            onClick={() => {
              void props.handleDelete();
            }}
          >
            <img src={closeLogo} className="h-4"></img>
          </button>
        </div>
      </div>

      <div className="w-full flex-auto p-3">
        <textarea
          className="h-full min-h-8 w-full resize-y rounded border border-gray-300 p-2 outline-none"
          placeholder="Add text here..."
          value={inputValue}
          onChange={handleChange}
        ></textarea>
      </div>
    </section>
  );
}

export function TextAnswer(props: {
  contentBlockAnswer: ContentBlockAnswer;
  handleDelete: () => Promise<void>;
}) {
  const [inputValue, setInputValue] = useState(
    props.contentBlockAnswer.content,
  );

  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    setInputValue(e.target.value);
  };

  return (
    <section className="flex h-auto w-full flex-col rounded border border-gray-300 bg-white first:border-b">
      <div className="w-full basis-11 border-b border-gray-300 px-4 py-2">
        <div className="flex h-full w-full justify-between">
          <div className="flex h-full items-center gap-2">
            <div className="flex h-7 w-7 items-center justify-center">
              <img src={inputLogo}></img>
            </div>
            <span className="text-sm">TEXT ANSWER</span>
          </div>

          <button
            className="basis-4"
            onClick={() => {
              void props.handleDelete();
            }}
          >
            <img src={closeLogo} className="h-4"></img>
          </button>
        </div>
      </div>

      <div className="w-full flex-auto p-8">
        <input
          type="text"
          className="h-full min-h-8 w-full border-b border-gray-300 outline-none"
          placeholder="Add question"
          value={inputValue}
          onChange={handleChange}
        ></input>
      </div>
    </section>
  );
}

export function MultipleChoice(props: {
  contentBlockMultipleChoice: ContentBlockMultipleChoice;
  handleDelete: () => Promise<void>;
}) {
  const [inputValue, setInputValue] = useState(
    props.contentBlockMultipleChoice.question,
  );

  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    setInputValue(e.target.value);
  };

  return (
    <section className="flex h-auto w-full flex-col rounded border border-gray-300 bg-white first:border-b">
      <div className="w-full basis-11 border-b border-gray-300 px-4 py-2">
        <div className="flex h-full w-full justify-between">
          <div className="flex h-full items-center gap-2">
            <div className="flex h-6 w-6 items-center justify-center">
              <img src={multipleChoiceLogo}></img>
            </div>
            <span className="text-sm">MULTIPLE CHOICE</span>
          </div>

          <button
            className="basis-4"
            onClick={() => {
              void props.handleDelete();
            }}
          >
            <img src={closeLogo} className="h-4"></img>
          </button>
        </div>
      </div>

      <div className="flex w-full flex-auto flex-col gap-4 p-8">
        <input
          type="text"
          className="h-full min-h-8 w-full border-b border-gray-300 outline-none"
          placeholder="Add question"
          value={inputValue}
          onChange={handleChange}
        ></input>

        <ul>
          {props.contentBlockMultipleChoice.options.map((option, index) => (
            <li key={index}>
              <div className="flex gap-2">
                <button className="basis-4">
                  <img src={closeLogo} className="h-4"></img>
                </button>
                <input id="question" type="checkbox" disabled={true}></input>
                <label htmlFor="question" className="text-sm">
                  {option.content}
                </label>
              </div>
            </li>
          ))}
        </ul>

        <div className="w-fit pl-8">
          <button className="w-fit text-sm text-blue-700">
            + Add new choice
          </button>
        </div>
      </div>
    </section>
  );
}
