// @ts-nocheck

// jest test syntax highlight
import name from 'module'

const a = 1
const b = () => ''
const c = {
  hello: 'world'
}

type NumberType = typeof a

type StringType = ReturnType<typeof b>

// utils type
type PType = Partial<typeof c>

export type { NumberType, StringType, PType }

interface TestInterface {
  a: string
}

const flag = 1 > 2

const d = async () => {
  return 1
}

const e = await d()

Required Readonly Record Pick Omit Exclude Extract NonNullable Parameters ReturnType 
