/**
 * @flow
 */

/**
 * Commands generate actions. When `repo.push` is
 * invoked, it processes a given command, returning an action to
 * represent the resolution of that command.
 */
declare type Command = Function | string

declare type Tagged = {
  name?: string,
  open?: string,
  inactive?: string,
  loading?: string,
  update?: string,
  done?: string,
  resolve?: string,
  error?: string,
  reject?: string,
  cancel?: string,
  cancelled?: string,
  __tagged?: boolean,
  toString: Function,
  apply: Function,
  call: Function
}

/**
 * Actions move through these unique states.
 */
declare type Status =
  | 'inactive'
  | 'open'
  | 'update'
  | 'resolve'
  | 'reject'
  | 'cancel'
