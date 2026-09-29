// TypeDoc's `ReflectionKind.TypeAlias`. Stable across TypeDoc versions but
// undocumented as a public contract — see TextsSignature/PageTextsSignature
// if this ever needs revisiting after a TypeDoc/kolay upgrade.
const TYPE_ALIAS_KIND = 2097152;

export interface CommentPart {
  kind: string;
  text: string;
}

export interface Comment {
  summary?: CommentPart[];
}

export interface TypeAliasChildType {
  name?: string;
  type?: string;
}

export interface TypeAliasChild {
  name: string;
  flags?: { isOptional?: boolean };
  type?: TypeAliasChildType;
  comment?: Comment;
}

export interface TypeAlias {
  kind: number;
  name: string;
  children: TypeAliasChild[];
}

// TypeDoc's JSON output is an arbitrarily nested tree of reflections whose
// exact shape isn't a documented contract; we only assert the fields we
// actually read as we walk it.
type ProjectNode = Record<string, unknown>;

const projectRequests = new Map<string, Promise<ProjectNode>>();

export function loadProject(packageName: string): Promise<ProjectNode> {
  if (!projectRequests.has(packageName)) {
    const slug = packageName.replace(/\//g, '__');

    projectRequests.set(
      packageName,
      fetch(`/docs/${slug}.json`).then((response) => response.json() as Promise<ProjectNode>),
    );
  }

  return projectRequests.get(packageName) as Promise<ProjectNode>;
}

export function findTypeAlias(node: unknown, name: string): TypeAlias | null {
  if (!node || typeof node !== 'object') return null;

  const candidate = node as ProjectNode;

  if (
    candidate.kind === TYPE_ALIAS_KIND &&
    candidate.name === name &&
    Array.isArray(candidate.children)
  ) {
    return candidate as unknown as TypeAlias;
  }

  for (const value of Object.values(candidate)) {
    if (Array.isArray(value)) {
      for (const item of value) {
        const found = findTypeAlias(item, name);
        if (found) return found;
      }
    } else if (value && typeof value === 'object') {
      const found = findTypeAlias(value, name);
      if (found) return found;
    }
  }

  return null;
}
