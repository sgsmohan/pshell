import pandas as pd

import tabula

def highlight_diff(data, color='yellow'):

    attr = 'background-color: {}'.format(color)

    data = data.style.applymap(lambda x: attr if x == True else '')

    return data

#convert PDFs to dataframes

df1 = tabula.read_pdf("file1.pdf", pages='all', multiple_tables=True, output_format="dataframe")

df2 = tabula.read_pdf("file2.pdf", pages='all', multiple_tables=True, output_format="dataframe")

# compare cell by cell

diff = df1 != df2

highlighted_diff = highlight_diff(diff)

# merge the two dataframes and the differences into a new dataframe

merged_df = pd.concat([df1, df2, highlighted_diff], axis=1)

# write the merged dataframe to a CSV file

merged_df.to_csv('output.csv', index=False)

