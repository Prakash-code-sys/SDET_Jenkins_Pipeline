
import { test, expect } from '@playwright/test';

import dotenv from 'dotenv'
dotenv.config()

test('Login',async({page})=>{
  await page.goto(process.env.BASE_URL)
  await page.locator('#user-name').fill(process.env.USER_NAME)
   await page.locator('#password').fill(process.env.PASS_WORD)
    await page.locator('#login-button').click()
})

