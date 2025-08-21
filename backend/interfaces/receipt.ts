export interface Receipt {
    id: string,
    vendor?: string,
    date?: string,
    total?: string,
    imageUrl: string,
    amount?: string | null
}

export interface PaginatedResult<T> {
  data: T[];         // array of items for the current page
  total: number;     // total number of items in the collection
  page: number;      // current page number
  limit: number;     // number of items per page
  totalPages: number;// total number of pages
}