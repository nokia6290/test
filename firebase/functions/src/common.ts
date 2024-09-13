export type CallableResponse = {
    status: number;
    error?: string;
    data?: object;
}

export const isNonEmptyString = (value: unknown): boolean => {
    return typeof value === "string" && value.length > 0;
};

export const isNonEmptyStringArray = (value: unknown): boolean => {
    return Array.isArray(value) &&
        value.every((item) => isNonEmptyString(item));
};
