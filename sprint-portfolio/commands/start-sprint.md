---
description: פתח ספרינט חדש — הקם את תיקיית הפרויקט (brief, resources, research, decisions, versions, metrics) ומלא את ה-brief
argument-hint: "[נתיב לתיקיית הפרויקט, או שם הפרויקט]"
---

הפעל את סקיל `design-journal` ב-Mode A (Start a sprint) כדי לפתוח פרויקט חדש כאן: $ARGUMENTS

1. העתק את `templates/project-skeleton/` (שליד סקיל design-journal) לתוך תיקיית הפרויקט — כך שנוצרות תת-התיקיות `resources/`, `research/`, `decisions/`, `versions/`, `metrics/` + `brief.md` + `journal.md`.
2. מלא איתי את `brief.md`: הבעיה, המשתמש, וה**מדד שרוצים להזיז (North-Star) + baseline** — קח מספר התחלתי אמיתי אם קיים.
3. הסבר לי בקצרה מה נכנס לכל תיקייה: רקע (מוצר, פרסונה, מתחרים) → `resources/`; מה שלמדתי (בדיקות, ראיונות, ציטוטים) → `research/`; מספרים → `metrics/`; כל החלטה/כיוון-שנפסל/פיבוט → `decisions/`.
4. מחק את קובצי ה-`EXAMPLE.md` ברגע שמתחיל תוכן אמיתי.

מכאן והלאה, לאורך הספרינט, זהה אוטומטית החלטות (Mode B), מדדים שזזו (Mode C) וממצאים/ציטוטים (Mode D) ותציע לתעד אותם — ואני תמיד יכול להפעיל `/log-decision` ידנית. בסוף: `/build-portfolio`.
