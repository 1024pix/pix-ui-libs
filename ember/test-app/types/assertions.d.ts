declare global {
  interface Assert {
    /** Asserts that the rendered output contains the given text. */
    contains(expected: string, message?: string): void;
  }
}

export {};
