import type { Metadata } from 'next';
import './globals.css';
export const metadata: Metadata = {
  title: 'Rangers Farm | Value Chain & Sustainability Manager',
  description: 'Daily farm costs, income, and Triple Bottom Line reporting for Rangers Farm.'
};
export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="en"><body>{children}</body></html>;
}
