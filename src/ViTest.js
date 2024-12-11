import {describe, test, vi, beforeAll, afterAll, beforeEach, afterEach} from "vitest"


export const testImpl = (name, t) => test(name, async () => {
    Object.defineProperty(window, 'matchMedia', {
        writable: true,
        value: vi.fn().mockImplementation((query) => ({
            matches: false,
            media: query,
            onchange: null,
            addListener: vi.fn(), // Deprecated
            removeListener: vi.fn(), // Deprecated
            addEventListener: vi.fn(),
            removeEventListener: vi.fn(),
            dispatchEvent: vi.fn(),
        })),
    })
    await t()
})


export const describeImpl = (name, t) => describe(name, t)

export const beforeAllImpl = (t) => beforeAll(t)

export const afterAllImpl = (t) => afterAll(t)

export const beforeEachImpl = (t) => beforeEach(t)

export const afterEachImpl = (t) => afterEach(t)